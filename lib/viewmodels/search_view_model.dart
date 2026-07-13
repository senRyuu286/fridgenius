import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../models/recipe.dart';

/// Holds the current search query text.
class SearchQueryViewModel extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryViewModel, String>(SearchQueryViewModel.new);

/// Recipes matching the current query by title or ingredient name.
/// An empty query returns the full list.
///
/// TODO(backend): replace with a Firestore / Gemini backed search.
final searchResultsProvider = Provider<List<Recipe>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  if (query.isEmpty) return MockData.recipes;
  return MockData.recipes.where((r) {
    final inTitle = r.title.toLowerCase().contains(query);
    final inIngredients =
        r.ingredients.any((i) => i.name.toLowerCase().contains(query));
    return inTitle || inIngredients;
  }).toList();
});
