import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/recipe.dart';
import '../repositories/favorites_repository.dart';
import 'auth_view_model.dart';

/// ViewModel for saved recipes. Loads the signed-in user's favorites from
/// Firestore and owns the favorite toggle used by the recipe detail screen so
/// both screens stay in sync.
class FavoritesViewModel extends AsyncNotifier<List<Recipe>> {
  @override
  Future<List<Recipe>> build() async {
    // Reload whenever the signed-in user changes.
    final user = ref.watch(authStateProvider).value;
    if (user == null) return const [];
    return ref.read(favoritesRepositoryProvider).fetchFavorites(user.uid);
  }

  bool isFavorite(String id) =>
      state.value?.any((r) => r.id == id) ?? false;

  /// Adds or removes [recipe], updating the UI optimistically and reverting if
  /// the Firestore write fails.
  Future<void> toggle(Recipe recipe) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    final repo = ref.read(favoritesRepositoryProvider);
    final previous = state.value ?? const [];
    final removing = isFavorite(recipe.id);

    state = AsyncData(
      removing
          ? previous.where((r) => r.id != recipe.id).toList()
          : [...previous, recipe],
    );

    try {
      if (removing) {
        await repo.removeFavorite(user.uid, recipe.id);
      } else {
        await repo.addFavorite(user.uid, recipe);
      }
    } catch (e, st) {
      // Revert the optimistic change and surface the error.
      state = AsyncData(previous);
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String id) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    final previous = state.value ?? const [];
    state = AsyncData(previous.where((r) => r.id != id).toList());
    try {
      await ref.read(favoritesRepositoryProvider).removeFavorite(user.uid, id);
    } catch (e, st) {
      state = AsyncData(previous);
      state = AsyncError(e, st);
    }
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesViewModel, List<Recipe>>(
  FavoritesViewModel.new,
);
