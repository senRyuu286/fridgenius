import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../models/recipe.dart';

/// ViewModel for the recipe results screen.
///
/// Returns the mock recipes ranked for display: exact matches (nothing
/// missing) first, then recipes that only need 1–2 extra items. Recipes that
/// need more than that are dropped so the list stays actionable.
///
/// TODO(backend): replace the static mock list with the ranked Gemini results
/// scored against the user's current ingredients.
final rankedRecipesProvider = Provider<List<Recipe>>((ref) {
  const maxMissing = 2;
  final ranked = MockData.recipes
      .where((r) => r.missingIngredients.length <= maxMissing)
      .toList()
    ..sort((a, b) =>
        a.missingIngredients.length.compareTo(b.missingIngredients.length));
  return ranked;
});
