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
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final recipeData =
          Map<String, dynamic>.from(data['recipe'] as Map? ?? const {});
      recipeData['id'] = doc.id;
      return Recipe.fromJson(recipeData);
    }).toList();
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
