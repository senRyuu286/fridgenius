import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../widgets/neo_widgets.dart';
import '../viewmodels/home_view_model.dart';

/// Home tab: browse all recipes as a colorful 2-column grid of tiles.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(allRecipesProvider);
    final initial = (MockData.user.displayName ?? 'F').characters.first;

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoHeader(
              title: 'My Recipes',
              subtitle: 'Browse everything, or cook from your fridge.',
              trailing: NeoAvatar(
                initial: initial,
                onTap: () => context.go('/profile'),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.80,
                ),
                itemCount: recipes.length,
                itemBuilder: (context, i) {
                  final recipe = recipes[i];
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
