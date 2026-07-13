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
    final recipes = ref.watch(rankedRecipesProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoHeader(
              title: 'Results',
              subtitle: '${recipes.length} recipes you can make now',
              onBack: () => _back(context),
            ),
            Expanded(
              child: ListView.separated(
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
