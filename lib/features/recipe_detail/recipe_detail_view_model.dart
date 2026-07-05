import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/recipe.dart';

/// ViewModel for the recipe detail screen: resolves a recipe by id.
///
/// Read-only — the favorite toggle is delegated to [favoritesProvider] so the
/// detail and favorites screens stay in sync.
/// TODO(backend): fetch the recipe (or a Gemini result) by id.
final recipeDetailProvider = Provider.family<Recipe, String>(
  (ref, recipeId) => MockData.byId(recipeId),
);
