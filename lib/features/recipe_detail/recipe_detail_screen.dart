import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/recipe.dart';
import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import '../favorites/favorites_screen.dart' show RecipeImageBlock;
import '../favorites/favorites_view_model.dart';
import 'recipe_detail_view_model.dart';

/// Recipe detail: hero image, title, tags, ingredients, steps, favorite toggle.
class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipeDetailProvider(recipeId));
    final isFavorite = ref.watch(
        favoritesProvider.select((list) => list.any((r) => r.id == recipeId)));

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoAppBar(
              title: recipe.title,
              onBack: () => _back(context),
              actionIcon:
                  isFavorite ? Icons.favorite : Icons.favorite_border,
              actionColor: isFavorite ? AppColors.coral : AppColors.white,
              onAction: () =>
                  ref.read(favoritesProvider.notifier).toggle(recipe),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  NeoCard(
                    padding: EdgeInsets.zero,
                    child: RecipeImageBlock(
                        recipe: recipe, height: 200, rounded: true),
                  ),
                  const SizedBox(height: 20),
                  Text(recipe.title, style: AppText.display),
                  const SizedBox(height: 8),
                  Text(recipe.description, style: AppText.body),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in MockData.tagsOf(recipe))
                        NeoPill(label: tag),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _Section(title: 'Ingredients', child: _Ingredients(recipe)),
                  const SizedBox(height: 20),
                  _Section(title: 'Steps', child: _Steps(recipe)),
                  const SizedBox(height: 24),
                  NeoButton(
                    label: isFavorite ? 'Saved to Favorites' : 'Save Recipe',
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    variant: isFavorite
                        ? NeoButtonVariant.secondary
                        : NeoButtonVariant.primary,
                    onPressed: () =>
                        ref.read(favoritesProvider.notifier).toggle(recipe),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/favorites');
    }
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.title),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _Ingredients extends StatelessWidget {
  const _Ingredients(this.recipe);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      child: Column(
        children: [
          for (final ing in recipe.ingredients)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    ing.isMissing
                        ? Icons.remove_circle_outline
                        : Icons.check_circle_outline,
                    size: 20,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(ing.name, style: AppText.body)),
                  Text(ing.amount, style: AppText.bodyBold),
                  if (ing.isMissing) ...[
                    const SizedBox(width: 8),
                    const NeoPill(label: 'need', color: AppColors.coral),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps(this.recipe);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < recipe.instructions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NeoCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      border: AppBorders.all,
                      borderRadius: AppRadii.pill,
                    ),
                    child: Text('${i + 1}', style: AppText.bodyBold),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(recipe.instructions[i], style: AppText.body)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
