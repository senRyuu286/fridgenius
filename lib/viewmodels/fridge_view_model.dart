import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ingredient.dart';

/// ViewModel for the Fridge tab: the list of ingredients the user has on hand,
/// with add / remove / clear actions.
///
/// TODO(backend): this list will feed the Gemini recipe request. For the
/// UI-build phase it is pure in-memory state seeded with a couple of examples.
class IngredientListViewModel extends Notifier<List<Ingredient>> {
  @override
  List<Ingredient> build() => const [
        Ingredient(id: 'seed-eggs', name: 'Eggs'),
        Ingredient(id: 'seed-spinach', name: 'Spinach'),
      ];

  /// Adds a trimmed ingredient, ignoring blanks and case-insensitive dupes.
  void add(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final exists =
        state.any((i) => i.name.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;
    state = [
      ...state,
      Ingredient(
          id: 'ing-${DateTime.now().microsecondsSinceEpoch}', name: trimmed),
    ];
  }

  void remove(String id) => state = state.where((i) => i.id != id).toList();

  void clear() => state = const [];
}

final ingredientListProvider =
    NotifierProvider<IngredientListViewModel, List<Ingredient>>(
        IngredientListViewModel.new);
