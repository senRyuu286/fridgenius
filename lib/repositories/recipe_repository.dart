import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';

/// Read access to the recipe catalogue (curated library + generated recipes).
abstract interface class RecipeRepository {
  /// The curated recipe library, used for the Home feed and as the fallback
  /// when Gemini fails or returns nothing.
  Future<List<Recipe>> fetchCuratedRecipes({int limit = 30});

  /// Resolves a single recipe by its Firestore id, or `null` if it's gone.
  Future<Recipe?> recipeById(String id);
}

/// Firestore-backed [RecipeRepository] reading the `recipes` collection.
class FirestoreRecipeRepository implements RecipeRepository {
  FirestoreRecipeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<List<Recipe>> fetchCuratedRecipes({int limit = 30}) async {
    final snapshot = await _firestore
        .collection('recipes')
        .where('isCurated', isEqualTo: true)
        .limit(limit)
        .get();
    return snapshot.docs.map(_fromDoc).toList();
  }

  @override
  Future<Recipe?> recipeById(String id) async {
    final doc = await _firestore.collection('recipes').doc(id).get();
    if (!doc.exists) return null;
    return _fromDoc(doc);
  }

  Recipe _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    data['id'] = doc.id;
    return Recipe.fromJson(data);
  }
}

/// Injects the app-wide [RecipeRepository]. Override in tests with a fake.
final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return FirestoreRecipeRepository();
});
