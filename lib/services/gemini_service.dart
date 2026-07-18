import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';

/// Typed failure modes a [GeminiService] call can surface, so the ViewModel can
/// react to each one (e.g. fall back to the curated library) instead of parsing
/// error strings.
sealed class GeminiFailure {
  const GeminiFailure(this.message);

  /// A short, developer-facing description of what went wrong.
  final String message;
}

/// The request took longer than the allowed budget.
class GeminiTimeoutFailure extends GeminiFailure {
  const GeminiTimeoutFailure([super.message = 'The recipe request timed out.']);
}

/// The model returned no text / an empty candidate.
class GeminiEmptyResultFailure extends GeminiFailure {
  const GeminiEmptyResultFailure([
    super.message = 'The model returned no recipes.',
  ]);
}

/// The response could not be decoded into the expected recipe shape.
class GeminiMalformedResponseFailure extends GeminiFailure {
  const GeminiMalformedResponseFailure([
    super.message = 'The model returned a response we could not read.',
  ]);
}

/// The Gemini/Firebase AI backend reported an error (quota, bad key, server,
/// disabled service, unsupported location, …).
class GeminiApiFailure extends GeminiFailure {
  const GeminiApiFailure(super.message);
}

/// Anything not covered by the cases above.
class GeminiUnknownFailure extends GeminiFailure {
  const GeminiUnknownFailure([super.message = 'An unexpected error occurred.']);
}

/// Thrown by [GeminiService] implementations. Carries a typed [failure] so
/// callers can `switch` on the concrete case.
class GeminiException implements Exception {
  const GeminiException(this.failure);

  final GeminiFailure failure;

  @override
  String toString() => 'GeminiException(${failure.runtimeType}: '
      '${failure.message})';
}

/// Turns a list of on-hand ingredients into ranked recipe suggestions.
///
/// Implementations MUST surface every failure path as a [GeminiException] with
/// a typed [GeminiFailure]; they must never silently swallow errors or perform
/// their own fallback. The curated-library fallback is owned by the ViewModel.
abstract interface class GeminiService {
  /// Returns 3–5 ranked recipes for [ingredients].
  ///
  /// Throws [GeminiException] on timeout, an empty result, a malformed
  /// response, or a backend/API error.
  Future<List<Recipe>> generateRecipes(List<String> ingredients);
}

/// [GeminiService] backed by Firebase AI (Gemini) with a Firestore-backed
/// response cache so identical ingredient sets don't re-hit the model.
class FirebaseGeminiService implements GeminiService {
  FirebaseGeminiService({
    FirebaseFirestore? firestore,
    GenerativeModel? model,
    Duration timeout = const Duration(seconds: 30),
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _timeout = timeout,
        _model = model ?? _defaultModel();

  final FirebaseFirestore _firestore;
  final GenerativeModel _model;
  final Duration _timeout;

  static GenerativeModel _defaultModel() {
    return FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.5-flash',
      systemInstruction: Content.system('''
            You are an expert culinary assistant for the Fridgenius! app. Your job is to turn the user's list of random kitchen ingredients into a cooked meal. You must return exactly 3 to 5 recipe suggestions based on the provided ingredients.

            CRITICAL RANKING RULES:
            1. Exact Matches First: Prioritize recipes that ONLY use the ingredients provided by the user.
            2. Minimal Additions: After exhausting exact matches, you may suggest recipes that require 1-2 extra pantry staples. Mark these extra ingredients with isMissing: true.

            SAFETY GUARDRAILS:
            - You must strictly adhere to basic food-safety rules. Explicitly state proper cooking times.
            - Do not suggest recipes combining strictly incompatible or unsafe ingredient mixtures.

            FORMATTING:
            - You are communicating directly with a mobile app database. Return ONLY the requested JSON structure. Do not include markdown formatting, conversational filler, or introductory text.
          '''),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.array(
          description:
              "A ranked list of recipes based on the user's provided ingredients.",
          items: Schema.object(
            properties: {
              "title": Schema.string(
                description: "A catchy, appetizing name for the recipe.",
              ),
              "description": Schema.string(
                description: "A short, mouth-watering description of the dish.",
              ),
              "prepTimeMinutes": Schema.integer(
                description: "Estimated prep time in minutes.",
              ),
              "cookTimeMinutes": Schema.integer(
                description: "Estimated cook time in minutes.",
              ),
              "difficulty": Schema.string(
                description: "Must be exactly one of: easy, medium, hard.",
              ),
              "ingredients": Schema.array(
                items: Schema.object(
                  properties: {
                    "name": Schema.string(),
                    "amount": Schema.string(),
                    "isMissing": Schema.boolean(
                      description:
                          "True if this ingredient was NOT provided by the user.",
                    ),
                  },
                ),
              ),
              "steps": Schema.array(
                items: Schema.object(
                  properties: {
                    "order": Schema.integer(
                      description: "1-based step number.",
                    ),
                    "instruction": Schema.string(
                      description: "The detailed action to perform.",
                    ),
                    "timerSeconds": Schema.integer(
                      description: "Wait/cook time in seconds.",
                      nullable: true,
                    ),
                    "title": Schema.string(
                      description: "Short label for the step.",
                      nullable: true,
                    ),
                  },
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  @override
  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    final normalizedIngredients =
        ingredients.map((e) => e.toLowerCase().trim()).toList()..sort();
    final hash = normalizedIngredients.join('_');

    try {
      // 1. Cache interception — return previously generated recipes if any.
      final cached = await _readCache(hash);
      if (cached != null && cached.isNotEmpty) return cached;

      // 2. Call the model (bounded by a timeout).
      final prompt = "Ingredients: ${normalizedIngredients.join(', ')}";
      final response = await _model
          .generateContent([Content.text(prompt)]).timeout(_timeout);

      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        throw const GeminiException(GeminiEmptyResultFailure());
      }

      // 3. Parse and persist.
      final recipes = _parseRecipes(text);
      if (recipes.isEmpty) {
        throw const GeminiException(GeminiEmptyResultFailure());
      }
      await _persist(hash, recipes);
      return recipes;
    } on GeminiException {
      rethrow;
    } on TimeoutException catch (e, st) {
      developer.log('GeminiService timeout', error: e, stackTrace: st);
      throw const GeminiException(GeminiTimeoutFailure());
    } on FormatException catch (e, st) {
      developer.log('GeminiService malformed JSON', error: e, stackTrace: st);
      throw const GeminiException(GeminiMalformedResponseFailure());
    } on FirebaseAIException catch (e, st) {
      developer.log('GeminiService API error', error: e, stackTrace: st);
      throw GeminiException(
        GeminiApiFailure(e.message.isEmpty ? e.toString() : e.message),
      );
    } catch (e, st) {
      developer.log('GeminiService unknown error', error: e, stackTrace: st);
      throw GeminiException(GeminiUnknownFailure(e.toString()));
    }
  }

  /// Decodes the model's JSON text into [Recipe]s, tagging each with a fresh
  /// Firestore id and the `gemini` source. Throws [FormatException] (mapped to
  /// [GeminiMalformedResponseFailure]) if the shape is wrong.
  List<Recipe> _parseRecipes(String text) {
    final decoded = jsonDecode(text);
    if (decoded is! List) {
      throw const FormatException('Expected a JSON array of recipes.');
    }

    final recipes = <Recipe>[];
    for (final entry in decoded) {
      if (entry is! Map<String, dynamic>) {
        throw const FormatException('Expected a JSON object per recipe.');
      }
      final docRef = _firestore.collection('recipes').doc();
      entry['id'] = docRef.id;
      entry['source'] = 'gemini';
      recipes.add(Recipe.fromJson(entry));
    }
    return recipes;
  }

  Future<List<Recipe>?> _readCache(String hash) async {
    final cacheDoc =
        await _firestore.collection('gemini_caches').doc(hash).get();
    if (!cacheDoc.exists) return null;

    final ids = (cacheDoc.data()?['cachedRecipeIds'] as List?)
            ?.cast<String>() ??
        const <String>[];
    if (ids.isEmpty) return null;
    return _fetchRecipesByIds(ids);
  }

  Future<void> _persist(String hash, List<Recipe> recipes) async {
    final batch = _firestore.batch();
    final savedIds = <String>[];

    for (final recipe in recipes) {
      final docRef = _firestore.collection('recipes').doc(recipe.id);
      final data = recipe.toJson();
      data['createdBy'] = 'gemini_ai';
      data['isCurated'] = false;
      data['isPublic'] = true;
      data['createdAt'] = FieldValue.serverTimestamp();
      batch.set(docRef, data);
      savedIds.add(recipe.id);
    }

    await batch.commit();
    await _firestore.collection('gemini_caches').doc(hash).set({
      'ingredientsHash': hash,
      'cachedRecipeIds': savedIds,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Recipe>> _fetchRecipesByIds(List<String> ids) async {
    if (ids.isEmpty) return const [];
    final snapshot = await _firestore
        .collection('recipes')
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Recipe.fromJson(data);
    }).toList();
  }
}

/// Injects the app-wide [GeminiService]. Override in tests with a fake.
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return FirebaseGeminiService();
});
