import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';
import 'home_view_model.dart';

/// Holds the current search query text.
class SearchQueryViewModel extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryViewModel, String>(SearchQueryViewModel.new);

/// Recipes from the curated library matching the current query by title or
/// ingredient name. An empty query returns no results, so the screen starts
/// empty until the user searches. Mirrors the library's [AsyncValue] so the
/// screen keeps its loading / error states.
final searchResultsProvider = Provider<AsyncValue<List<Recipe>>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final library = ref.watch(allRecipesProvider);
  return library.whenData((recipes) {
    if (query.isEmpty) return const <Recipe>[];
    return recipes.where((r) {
      final inTitle = r.title.toLowerCase().contains(query);
      final inIngredients =
          r.ingredients.any((i) => i.name.toLowerCase().contains(query));
      return inTitle || inIngredients;
    }).toList();
  });
});
