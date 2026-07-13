import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';
import '../widgets/neo_widgets.dart';
import '../viewmodels/favorites_view_model.dart';

/// Favorites: saved recipes as a grid of tiles, with an empty-state variant.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            const NeoHeader(title: 'Saved'),
            Expanded(
              child: favorites.isEmpty
                  ? const _EmptyFavorites()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, i) {
                        final recipe = favorites[i];
                        return RecipeTile(
                          recipe: recipe,
                          onTap: () => context.push('/recipe/${recipe.id}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: NeoCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  border: AppBorders.all,
                  borderRadius: AppRadii.cardRadius,
                ),
                child: const Text('🗂️', style: TextStyle(fontSize: 44)),
              ),
              const SizedBox(height: 20),
              Text('NO FAVORITES YET',
                  style: AppText.title, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Recipes you save will show up here so they are ready when '
                'hunger strikes.',
                style: AppText.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              NeoButton(
                label: 'Browse Recipes',
                icon: Icons.search,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
