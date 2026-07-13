import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';

/// Phase 1 deliverable: a preview of the neo-brutalism theme + reusable widgets.
/// Not part of the app flow — reachable at the /gallery route for review.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            const NeoAppBar(title: 'Neo Gallery'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _section('Typography'),
                  Text('Display / Archivo Black', style: AppText.display),
                  const SizedBox(height: 4),
                  Text('Title', style: AppText.title),
                  Text('Body copy set in Inter for comfortable reading.',
                      style: AppText.body),
                  const SizedBox(height: 24),
                  _section('Buttons'),
                  const NeoButton(label: 'Primary', onPressed: _noop),
                  const SizedBox(height: 12),
                  const NeoButton(
                      label: 'Secondary',
                      variant: NeoButtonVariant.secondary,
                      onPressed: _noop),
                  const SizedBox(height: 12),
                  const NeoButton(
                      label: 'Light + Icon',
                      icon: Icons.bolt,
                      variant: NeoButtonVariant.light,
                      onPressed: _noop),
                  const SizedBox(height: 12),
                  const NeoButton(label: 'Disabled', onPressed: null),
                  const SizedBox(height: 24),
                  _section('Pills'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      NeoPill(label: 'Easy'),
                      NeoPill(label: '25 min', color: AppColors.coral),
                      NeoPill(
                          label: 'Vegetarian',
                          color: AppColors.mint,
                          icon: Icons.eco),
                      NeoPill(label: 'Saved', color: AppColors.white),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _section('Card'),
                  NeoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NeoCard', style: AppText.heading),
                        const SizedBox(height: 6),
                        Text(
                            'A bordered surface with a hard 5px offset shadow '
                            'and no blur.',
                            style: AppText.body),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _section('Text field'),
                  const NeoTextField(
                    label: 'Email',
                    hint: 'you@fridgenius.app',
                    prefixIcon: Icons.mail_outline,
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

  static void _noop() {}

  Widget _section(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(label.toUpperCase(),
            style: AppText.caption.copyWith(
                fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      );
}
