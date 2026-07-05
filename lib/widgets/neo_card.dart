import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A bordered, hard-shadowed surface — the base container for the design system.
class NeoCard extends StatelessWidget {
  const NeoCard({
    super.key,
    required this.child,
    this.color = AppColors.white,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.radius,
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: AppBorders.all,
        borderRadius: radius ?? AppRadii.cardRadius,
        boxShadow: AppShadows.hard,
      ),
      child: child,
    );
    if (onTap == null) return card;
    return GestureDetector(onTap: onTap, child: card);
  }
}
