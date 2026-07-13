import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../models/recipe.dart';

/// ViewModel for saved recipes. Also owns the favorite toggle used by the
/// recipe detail screen so both screens stay in sync.
class FavoritesViewModel extends Notifier<List<Recipe>> {
  @override
  List<Recipe> build() =>
      // TODO(backend): load the user's saved recipes from Firestore.
      List<Recipe>.from(MockData.recipes.take(3));

  bool isFavorite(String id) => state.any((r) => r.id == id);

  void toggle(Recipe recipe) {
    if (isFavorite(recipe.id)) {
      state = state.where((r) => r.id != recipe.id).toList();
    } else {
      state = [...state, recipe];
    }
    // TODO(backend): persist the change to Firestore.
  }

  void remove(String id) =>
      state = state.where((r) => r.id != id).toList();
}

final favoritesProvider =
    NotifierProvider<FavoritesViewModel, List<Recipe>>(FavoritesViewModel.new);
