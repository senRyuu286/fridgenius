import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import '../services/gemini_service.dart';
import 'fridge_view_model.dart';

/// How many extra (missing) ingredients a Gemini recipe may need before it's
/// considered too much of a stretch to surface.
const _maxMissing = 2;

/// ViewModel for the recipe results screen.
///
/// Runs the current fridge ingredients through [GeminiService], ranks the
/// results (exact matches first, then recipes needing 1–2 extra items), and
/// falls back to the curated library when Gemini fails or returns nothing —
/// so the screen always has something to show.
///
/// Exposes an [AsyncValue] so the screen drives its own loading / error /
/// empty states.
final rankedRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final ingredients =
      ref.watch(ingredientListProvider).map((i) => i.name).toList();
  final gemini = ref.watch(geminiServiceProvider);
  final recipes = ref.watch(recipeRepositoryProvider);

  List<Recipe> generated = const [];
  try {
    generated = await gemini.generateRecipes(ingredients);
  } on GeminiException {
    // Typed failure — fall through to the curated fallback below.
    generated = const [];
  }

  final ranked = _rank(generated);
  if (ranked.isNotEmpty) return ranked;

  // Gemini failed, returned nothing, or nothing was close enough to cook —
  // let the curated library fill the gap.
  final curated = await recipes.fetchCuratedRecipes();
  return _sortByMissing(curated);
});

/// Keeps only recipes within [_maxMissing] extra items, exact matches first.
List<Recipe> _rank(List<Recipe> recipes) {
  final filtered = recipes
      .where((r) => r.missingIngredients.length <= _maxMissing)
      .toList();
  return _sortByMissing(filtered);
}

/// Sorts by how many ingredients are missing (fewest first), without dropping
/// any — used for the curated fallback so the screen is never left empty.
List<Recipe> _sortByMissing(List<Recipe> recipes) {
  final sorted = [...recipes]..sort(
      (a, b) =>
          a.missingIngredients.length.compareTo(b.missingIngredients.length),
    );
  return sorted;
}
