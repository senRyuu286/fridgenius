import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/app_theme.dart';

/// A single onboarding value-prop page.
class OnboardingPage {
  const OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
}

/// ViewModel for the onboarding flow: tracks the active page index.
class OnboardingViewModel extends Notifier<int> {
  @override
  int build() => 0;

  void setPage(int index) => state = index;

  static const List<OnboardingPage> pages = [
    OnboardingPage(
      emoji: '🧊',
      title: 'What\'s in your fridge?',
      subtitle:
          'Snap or list the ingredients you already have and let Fridgenius '
          'do the thinking.',
      color: AppColors.coral,
    ),
    OnboardingPage(
      emoji: '✨',
      title: 'Ranked recipe ideas',
      subtitle:
          'Get smart, ranked recipe suggestions tuned to what you can cook '
          'right now.',
      color: AppColors.gold,
    ),
    OnboardingPage(
      emoji: '🍳',
      title: 'Cook it, share it',
      subtitle:
          'Save favorites, build a daily cooking habit and share wins with '
          'the community.',
      color: AppColors.mint,
    ),
  ];
}

final onboardingProvider =
    NotifierProvider<OnboardingViewModel, int>(OnboardingViewModel.new);
