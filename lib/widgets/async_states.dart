import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'neo_button.dart';
import 'neo_card.dart';

/// Shared loading / error / empty placeholders used to drive screen state from
/// an [AsyncValue]. They reuse the existing neo-brutalist tokens and mirror the
/// look of the screens' own empty states — no new styling.

/// Centered loading spinner.
class AsyncLoadingView extends StatelessWidget {
  const AsyncLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.black),
    );
  }
}

/// Centered error card with an optional retry action.
class AsyncErrorView extends StatelessWidget {
  const AsyncErrorView({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

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
                  color: AppColors.alert,
                  border: AppBorders.all,
                  borderRadius: AppRadii.cardRadius,
                ),
                child: const Text('⚠️', style: TextStyle(fontSize: 44)),
              ),
              const SizedBox(height: 20),
              Text('SOMETHING WENT WRONG',
                  style: AppText.title, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(message, style: AppText.body, textAlign: TextAlign.center),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                NeoButton(
                  label: 'Try Again',
                  icon: Icons.refresh,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Centered empty-state card.
class AsyncEmptyView extends StatelessWidget {
  const AsyncEmptyView({
    super.key,
    required this.emoji,
    required this.title,
    required this.message,
  });

  final String emoji;
  final String title;
  final String message;

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
                child: Text(emoji, style: const TextStyle(fontSize: 44)),
              ),
              const SizedBox(height: 20),
              Text(title, style: AppText.title, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(message, style: AppText.body, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
