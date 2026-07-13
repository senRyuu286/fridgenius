import 'package:flutter/material.dart';

import '../utils/mock_data.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import 'neo_pill.dart';

/// Black status chip: "READY" (exact match) or "MISSING N" (needs items),
/// with a colored label so it pops off the black like the reference pills.
class RecipeStatusPill extends StatelessWidget {
  const RecipeStatusPill({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final missing = recipe.missingIngredients.length;
    if (recipe.isExactMatch) {
      return const NeoPill(
        label: 'READY',
        color: AppColors.black,
        textColor: AppColors.mint,
        icon: Icons.check,
      );
    }
    return NeoPill(
      label: 'MISSING $missing',
      color: AppColors.black,
      textColor: AppColors.alert,
      icon: Icons.error_outline,
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
        border: rounded ? const Border(bottom: AppBorders.side) : null,
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

/// Bold, fully color-filled grid tile (the "locker" format). Emoji + a black
/// handle bar up top, title, then time + status pills. Used on Home / Search /
/// Favorites.
class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key, required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = MockData.accentOf(recipe);
    final ink = AppColors.inkOn(accent);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: accent,
          border: AppBorders.all,
          borderRadius: AppRadii.cardRadius,
          boxShadow: AppShadows.hard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MockData.emojiOf(recipe),
                    style: const TextStyle(fontSize: 32)),
                const Spacer(),
                // Locker-handle homage.
                Container(
                  width: 9,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              recipe.title,
              style: AppText.heading.copyWith(color: ink),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                RecipeStatusPill(recipe: recipe),
                NeoPill(
                  label: '${recipe.totalTimeMinutes} MIN',
                  color: AppColors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// White list row with a colored accent stripe, title and a time · status
/// meta line. Used for the ranked Results list (reference event-card format).
class RecipeRow extends StatelessWidget {
  const RecipeRow({super.key, required this.recipe, required this.onTap});

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = MockData.accentOf(recipe);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: AppBorders.all,
          borderRadius: AppRadii.cardRadius,
          boxShadow: AppShadows.hard,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: accent,
                  border: AppBorders.all,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${MockData.emojiOf(recipe)}  ${recipe.title}',
                        style: AppText.heading,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 14),
                        const SizedBox(width: 4),
                        Text('${recipe.totalTimeMinutes} MIN',
                            style: AppText.caption),
                        const SizedBox(width: 10),
                        RecipeStatusPill(recipe: recipe),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
