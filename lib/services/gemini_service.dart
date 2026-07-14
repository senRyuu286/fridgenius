import 'dart:convert';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';

import '../models/recipe.dart';

class GeminiService {
  final FirebaseFirestore _firestore;
  final GenerativeModel _model;

  GeminiService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _model = FirebaseAI.googleAI().generativeModel(
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
                  description:
                      "A short, mouth-watering description of the dish.",
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

  /// Generates or fetches recipes based on a list of ingredients.
  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    final normalizedIngredients =
        ingredients.map((e) => e.toLowerCase().trim()).toList()..sort();
    final hash = normalizedIngredients.join('_');

    try {
      // 1. Cache Interception
      final cacheDoc = await _firestore
          .collection('gemini_caches')
          .doc(hash)
          .get();

      if (cacheDoc.exists) {
        final List<dynamic> cachedIds =
            cacheDoc.data()?['cachedRecipeIds'] ?? [];
        if (cachedIds.isNotEmpty) {
          return await _fetchRecipesByIds(List<String>.from(cachedIds));
        }
      }

      // 2. The API Call
      final prompt = "Ingredients: ${normalizedIngredients.join(', ')}";
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception("Gemini returned an empty response.");
      }

      // 3. Parse and Map to Freezed Objects
      final List<dynamic> rawJson = jsonDecode(response.text!);
      final List<Recipe> newRecipes = [];
      final batch = _firestore.batch();
      final List<String> savedIds = [];

      for (var jsonMap in rawJson) {
        if (jsonMap is Map<String, dynamic>) {
          // Generate the Firestore ID before parsing so the Freezed model has it
          final docRef = _firestore.collection('recipes').doc();

          jsonMap['id'] = docRef.id;
          jsonMap['source'] =
              'gemini'; // Maps to the @Default('gemini') fallback

          // Confidently parse into the Freezed model!
          final recipe = Recipe.fromJson(jsonMap);
          newRecipes.add(recipe);
          savedIds.add(docRef.id);

          // 4. Save to Firestore
          final firestoreData = recipe.toJson();
          // Inject required metadata for security rules & queries
          firestoreData['createdBy'] = 'gemini_ai';
          firestoreData['isCurated'] = false;
          firestoreData['isPublic'] = true;
          firestoreData['createdAt'] = FieldValue.serverTimestamp();

          batch.set(docRef, firestoreData);
        }
      }

      // 5. Commit Batch & Update Cache
      if (newRecipes.isNotEmpty) {
        await batch.commit();
        await _firestore.collection('gemini_caches').doc(hash).set({
          'ingredientsHash': hash,
          'cachedRecipeIds': savedIds,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return newRecipes;
    } catch (e) {
      // Replaced print() with proper logging
      developer.log("GeminiService Error", error: e);
      return await _fetchCuratedFallback();
    }
  }

  // --- Helper Methods ---

  Future<List<Recipe>> _fetchRecipesByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

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

  Future<List<Recipe>> _fetchCuratedFallback() async {
    final snapshot = await _firestore
        .collection('recipes')
        .where('isCurated', isEqualTo: true)
        .limit(5)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Recipe.fromJson(data);
    }).toList();
  }
}
