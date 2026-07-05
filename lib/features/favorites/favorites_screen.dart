import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/recipe.dart';
import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import 'favorites_view_model.dart';

/// Favorites: list of saved recipe cards, with an empty-state variant.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoAppBar(
              title: 'Favorites',
              actionIcon: Icons.person_outline,
              actionColor: AppColors.white,
              onAction: () => context.go('/profile'),
            ),
            Expanded(
              child: favorites.isEmpty
                  ? const _EmptyFavorites()
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: favorites.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, i) {
                        final recipe = favorites[i];
                        return _FavoriteCard(
                          recipe: recipe,
                          onTap: () => context.go('/recipe/${recipe.id}'),
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

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecipeImageBlock(recipe: recipe, height: 120, rounded: true),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.title, style: AppText.heading),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in MockData.tagsOf(recipe))
                      NeoPill(label: tag),
                  ],
                ),
              ],
            ),
          ),
        ],
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
              Text('No favorites yet',
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
                label: 'Discover Recipes',
                icon: Icons.search,
                onPressed: () => context.go('/recipe/r1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Flat color image placeholder for a recipe (offline-safe, in-system).
/// TODO(backend): swap for the recipe's real network image.
class RecipeImageBlock extends StatelessWidget {
  const RecipeImageBlock({
    super.key,
    required this.recipe,
    required this.height,
    this.rounded = false,
  });

  final Recipe recipe;
  final double height;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MockData.accentOf(recipe),
        border: rounded
            ? const Border(bottom: AppBorders.side)
            : null,
        borderRadius: rounded
            ? const BorderRadius.vertical(
                top: Radius.circular(AppRadii.card - AppBorders.width))
            : null,
      ),
      child: Text(MockData.emojiOf(recipe),
          style: const TextStyle(fontSize: 56)),
    );
  }
}
