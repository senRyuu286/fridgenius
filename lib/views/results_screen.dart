import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/neo_widgets.dart';
import '../viewmodels/results_view_model.dart';

/// Recipe results: ranked recipe rows. Exact matches come first, then recipes
/// that only need 1–2 extra items (flagged with a "missing" badge).
class RecipeResultsScreen extends ConsumerWidget {
  const RecipeResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(rankedRecipesProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoHeader(
              title: 'Results',
              subtitle: recipesAsync.maybeWhen(
                data: (recipes) =>
                    '${recipes.length} recipes you can make now',
                orElse: () => 'Finding recipes for your fridge…',
              ),
              onBack: () => _back(context),
            ),
            Expanded(
              child: recipesAsync.when(
                loading: () => const AsyncLoadingView(),
                error: (e, _) => AsyncErrorView(
                  message: 'We couldn\'t generate recipes right now.',
                  onRetry: () => ref.invalidate(rankedRecipesProvider),
                ),
                data: (recipes) {
                  if (recipes.isEmpty) {
                    return const AsyncEmptyView(
                      emoji: '🧑‍🍳',
                      title: 'NO RECIPES YET',
                      message:
                          'We couldn\'t find a dish for these ingredients. '
                          'Try adding a few more to your fridge.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    itemCount: recipes.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, i) {
                      final recipe = recipes[i];
                      return RecipeRow(
                        recipe: recipe,
                        onTap: () => context.push('/recipe/${recipe.id}'),
                      );
                    },
                  );
                },
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
      context.go('/fridge');
    }
  }
}
