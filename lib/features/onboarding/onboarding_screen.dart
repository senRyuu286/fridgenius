import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import 'onboarding_view_model.dart';

/// Onboarding: 3 swipeable value-prop pages, page indicator, Get Started CTA.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingViewModel.pages;
    final index = ref.watch(onboardingProvider);
    final isLast = index == pages.length - 1;

    return Scaffold(
      body: DottedBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () => context.go('/signin'),
                    child: Text('Skip',
                        style: AppText.bodyBold.copyWith(color: AppColors.black)),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged:
                      ref.read(onboardingProvider.notifier).setPage,
                  itemBuilder: (context, i) => _OnboardingPageView(pages[i]),
                ),
              ),
              _PageIndicator(count: pages.length, active: index),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                child: NeoButton(
                  label: isLast ? 'Get Started' : 'Next',
                  icon: isLast ? Icons.arrow_forward : null,
                  onPressed: () {
                    if (isLast) {
                      context.go('/signin');
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView(this.page);

  final OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: page.color,
              border: AppBorders.all,
              borderRadius: AppRadii.cardRadius,
              boxShadow: AppShadows.hard,
            ),
            child: Text(page.emoji, style: const TextStyle(fontSize: 76)),
          ),
          const SizedBox(height: 40),
          Text(page.title, textAlign: TextAlign.center, style: AppText.display),
          const SizedBox(height: 16),
          Text(page.subtitle,
              textAlign: TextAlign.center, style: AppText.body),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 14,
          height: 14,
          decoration: BoxDecoration(
            color: isActive ? AppColors.coral : AppColors.white,
            border: AppBorders.all,
            borderRadius: AppRadii.pill,
          ),
        );
      }),
    );
  }
}
