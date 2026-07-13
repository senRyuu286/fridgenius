import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';
import '../widgets/neo_widgets.dart';
import '../viewmodels/fridge_view_model.dart';

/// Fridge tab: add the ingredients you have on hand as removable chips, then
/// generate ranked recipes you can cook right now.
class FridgeScreen extends ConsumerStatefulWidget {
  const FridgeScreen({super.key});

  @override
  ConsumerState<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends ConsumerState<FridgeScreen> {
  final _controller = TextEditingController();
  String _draft = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    ref.read(ingredientListProvider.notifier).add(_controller.text);
    _controller.clear();
    setState(() => _draft = '');
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = ref.watch(ingredientListProvider);
    final canAdd = _draft.trim().isNotEmpty;
    final canGenerate = ingredients.isNotEmpty;

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            const NeoHeader(
              title: 'Fridge',
              subtitle: 'Add what you have — get recipes you can cook now.',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                children: [
                  NeoTextField(
                    label: 'Add an ingredient',
                    hint: 'e.g. Tomatoes',
                    controller: _controller,
                    prefixIcon: Icons.add,
                    onChanged: (v) => setState(() => _draft = v),
                  ),
                  const SizedBox(height: 12),
                  NeoButton(
                    label: 'Add Ingredient',
                    icon: Icons.add,
                    variant: NeoButtonVariant.secondary,
                    onPressed: canAdd ? _add : null,
                  ),
                  const SizedBox(height: 28),
                  Text('Your ingredients', style: AppText.heading),
                  const SizedBox(height: 12),
                  if (ingredients.isEmpty)
                    _EmptyIngredients()
                  else
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final ing in ingredients)
                          NeoPill(
                            label: ing.name,
                            color: AppColors.white,
                            onRemove: () => ref
                                .read(ingredientListProvider.notifier)
                                .remove(ing.id),
                          ),
                      ],
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: NeoButton(
                  label: 'Generate Recipes',
                  icon: Icons.auto_awesome,
                  onPressed:
                      canGenerate ? () => context.push('/results') : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeoCard(
      color: AppColors.cream,
      child: Row(
        children: [
          const Text('🧺', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No ingredients yet — add a few above to get started.',
              style: AppText.body,
            ),
          ),
        ],
      ),
    );
  }
}
