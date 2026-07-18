import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';
import '../widgets/neo_widgets.dart';
import '../viewmodels/home_view_model.dart';
import '../viewmodels/search_view_model.dart';

/// Search tab: filter recipes by name or ingredient, shown as a grid.
class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            const NeoHeader(title: 'Search'),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: NeoTextField(
                label: 'Find a recipe',
                hint: 'e.g. Pasta, Tacos, Avocado',
                prefixIcon: Icons.search,
                onChanged: ref.read(searchQueryProvider.notifier).setQuery,
              ),
            ),
            Expanded(
              child: results.when(
                loading: () => const AsyncLoadingView(),
                error: (e, _) => AsyncErrorView(
                  message: 'We couldn\'t load recipes to search.',
                  onRetry: () => ref.invalidate(allRecipesProvider),
                ),
                data: (recipes) => recipes.isEmpty
                    ? (query.trim().isEmpty
                        ? const _SearchPrompt()
                        : _NoResults(query: query))
                    : GridView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown on first access, before the user has typed a query.
class _SearchPrompt extends StatelessWidget {
  const _SearchPrompt();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: NeoCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔍', style: TextStyle(fontSize: 44)),
              const SizedBox(height: 16),
              Text('SEARCH RECIPES', style: AppText.title),
              const SizedBox(height: 8),
              Text(
                'Type an ingredient or dish above to find recipes.',
                style: AppText.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: NeoCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔍', style: TextStyle(fontSize: 44)),
              const SizedBox(height: 16),
              Text('NO MATCHES', style: AppText.title),
              const SizedBox(height: 8),
              Text(
                'Nothing found for "$query". Try a different ingredient or dish.',
                style: AppText.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
