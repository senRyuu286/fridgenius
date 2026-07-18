import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';

/// Persists a user's saved recipes.
abstract interface class FavoritesRepository {
  /// The user's saved recipes, newest first.
  Future<List<Recipe>> fetchFavorites(String userId);

  /// Saves [recipe] for [userId] (idempotent — keyed by recipe id).
  Future<void> addFavorite(String userId, Recipe recipe);

  /// Removes the saved recipe [recipeId] for [userId].
  Future<void> removeFavorite(String userId, String recipeId);
}

/// Firestore-backed [FavoritesRepository] storing a full recipe snapshot under
/// `users/{userId}/favorites/{recipeId}`.
class FirestoreFavoritesRepository implements FavoritesRepository {
  FirestoreFavoritesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String userId) =>
      _firestore.collection('users').doc(userId).collection('favorites');

  @override
  Future<List<Recipe>> fetchFavorites(String userId) async {
    final snapshot =
        await _col(userId).orderBy('savedAt', descending: true).get();

    final recipes = <Recipe>[];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      // Real recipe id: seed favorites carry a `recipeId` field; app-written
      // favorites use the recipe id as the favorite doc id.
      final recipeId = (data['recipeId'] as String?) ?? doc.id;
      try {
        // Prefer the canonical recipe from the catalog so favorites always
        // render with full data, even if only a thin snapshot was saved.
        final catalogDoc =
            await _firestore.collection('recipes').doc(recipeId).get();
        if (catalogDoc.exists) {
          final rd = catalogDoc.data() ?? <String, dynamic>{};
          rd['id'] = catalogDoc.id;
          recipes.add(Recipe.fromJson(rd));
          continue;
        }
        // Fall back to the stored snapshot. Schema varies across writers:
        // `recipe` (app) or `recipeSnapshot` (seed).
        final snap = (data['recipe'] ?? data['recipeSnapshot']) as Map?;
        if (snap != null) {
          final rd = Map<String, dynamic>.from(snap);
          rd['id'] = recipeId;
          recipes.add(Recipe.fromJson(rd));
        }
      } catch (_) {
        // Skip a single malformed favorite rather than failing the whole list.
      }
    }
    return recipes;
  }

  @override
  Future<void> addFavorite(String userId, Recipe recipe) async {
    await _col(userId).doc(recipe.id).set({
      'userId': userId,
      'recipe': recipe.toJson(),
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> removeFavorite(String userId, String recipeId) async {
    await _col(userId).doc(recipeId).delete();
  }
}

/// Injects the app-wide [FavoritesRepository]. Override in tests with a fake.
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FirestoreFavoritesRepository();
});
