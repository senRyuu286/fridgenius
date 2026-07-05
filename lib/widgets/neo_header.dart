import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Page header in the reference style: a big Archivo Black title sitting
/// directly on the dotted background (no filled app bar), with an optional
/// square back button on the left and an optional trailing widget (avatar or
/// action buttons) on the right.
class NeoHeader extends StatelessWidget {
  const NeoHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.subtitle,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (onBack != null) ...[
                  NeoSquareButton(icon: Icons.arrow_back, onTap: onBack!),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: AppText.display,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 12),
                  trailing!,
                ],
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!, style: AppText.body),
            ],
          ],
        ),
      ),
    );
  }
}

/// Small bordered square button (back / action slots), with hard shadow.
class NeoSquareButton extends StatelessWidget {
  const NeoSquareButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = AppColors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: AppBorders.all,
          borderRadius: AppRadii.buttonRadius,
          boxShadow: AppShadows.hard,
        ),
        child: Icon(icon, color: AppColors.black, size: 20),
      ),
    );
  }
}

/// Circular initial avatar used in the header (reference "J" chip).
class NeoAvatar extends StatelessWidget {
  const NeoAvatar({super.key, required this.initial, this.onTap});

  final String initial;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.avatar,
        shape: BoxShape.circle,
        border: Border.fromBorderSide(AppBorders.side),
        boxShadow: AppShadows.hard,
      ),
      child: Text(
        initial.toUpperCase(),
        style: AppText.bodyBold.copyWith(color: AppColors.white, fontSize: 16),
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(
        onTap: onTap, behavior: HitTestBehavior.opaque, child: chip);
  }
}
