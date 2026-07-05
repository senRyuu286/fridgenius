import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Fully-rounded, filled tag with a 3px black border and black label.
class NeoPill extends StatelessWidget {
  const NeoPill({
    super.key,
    required this.label,
    this.color = AppColors.gold,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        border: AppBorders.all,
        borderRadius: AppRadii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.black),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppText.pill),
        ],
      ),
    );
  }
}
