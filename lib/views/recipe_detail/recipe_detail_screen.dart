import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/mock_data.dart';
import '../../models/recipe.dart';
import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import '../../viewmodels/favorites_view_model.dart';
import '../../viewmodels/recipe_detail_view_model.dart';

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
            NeoHeader(
              title: recipe.title,
              onBack: () => _back(context),
              trailing: NeoSquareButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppColors.coral : AppColors.white,
                onTap: () =>
                    ref.read(favoritesProvider.notifier).toggle(recipe),
              ),
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
                  const SizedBox(height: 16),
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
      context.go('/home');
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
                    const NeoPill(label: 'missing', color: AppColors.alert),
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
        for (final step in recipe.steps)
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
                    child: Text('${step.order}', style: AppText.bodyBold),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (step.title != null) ...[
                          Text(step.title!, style: AppText.bodyBold),
                          const SizedBox(height: 4),
                        ],
                        Text(step.instruction, style: AppText.body),
                        if (step.timerSeconds != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                _formatTimer(step.timerSeconds!),
                                style: AppText.bodyBold,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;
    if (minutes == 0) return '${remaining}s';
    if (remaining == 0) return '${minutes} min';
    return '${minutes}m ${remaining}s';
  }
}