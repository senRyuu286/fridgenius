import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

/// ViewModel for the Home tab: the curated recipe library from Firestore.
///
/// Exposes an [AsyncValue] so the screen can drive its own loading / error /
/// empty states.
final allRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  return ref.watch(recipeRepositoryProvider).fetchCuratedRecipes();
});
