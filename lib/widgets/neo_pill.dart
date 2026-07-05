import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Fully-rounded, filled tag with a 3px black border and black label.
///
/// Pass [onRemove] to render a trailing ✕ that turns the pill into a
/// removable chip (used by the ingredient input screen).
class NeoPill extends StatelessWidget {
  const NeoPill({
    super.key,
    required this.label,
    this.color = AppColors.gold,
    this.textColor = AppColors.black,
    this.icon,
    this.onRemove,
  });

  final String label;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: onRemove == null ? 12 : 6,
        top: 6,
        bottom: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        border: AppBorders.all,
        borderRadius: AppRadii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppText.pill.copyWith(color: textColor)),
          if (onRemove != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Icon(Icons.close, size: 16, color: textColor),
            ),
          ],
        ],
      ),
    );
  }
}
