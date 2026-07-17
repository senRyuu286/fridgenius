import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

/// ViewModel for the recipe detail screen: resolves a recipe by id from the
/// recipe repository.
///
/// Read-only — the favorite toggle is delegated to [favoritesProvider] so the
/// detail and favorites screens stay in sync. Exposes an [AsyncValue] so the
/// screen can drive loading / error states.
final recipeDetailProvider = FutureProvider.family<Recipe, String>(
  (ref, recipeId) async {
    final recipe = await ref.watch(recipeRepositoryProvider).recipeById(
          recipeId,
        );
    if (recipe == null) {
      throw StateError('Recipe "$recipeId" was not found.');
    }
    return recipe;
  },
);
