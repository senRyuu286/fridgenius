import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Top app bar: thick bottom border, hard shadow, Archivo Black title,
/// optional back button (leading) and a single trailing action slot.
///
/// Placed at the top of a screen body (inside a Column), so it sits above the
/// scrollable content and handles the status bar itself.
class NeoAppBar extends StatelessWidget {
  const NeoAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actionIcon,
    this.onAction,
    this.actionColor = AppColors.white,
    this.backgroundColor = AppColors.gold,
  });

  final String title;
  final VoidCallback? onBack;
  final IconData? actionIcon;
  final VoidCallback? onAction;
  final Color actionColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(bottom: AppBorders.side),
        boxShadow: AppShadows.hard,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                if (onBack != null)
                  _NeoBarButton(icon: Icons.arrow_back, onTap: onBack!)
                else
                  const SizedBox(width: 44),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.title,
                  ),
                ),
                if (actionIcon != null)
                  _NeoBarButton(
                    icon: actionIcon!,
                    color: actionColor,
                    onTap: onAction,
                  )
                else
                  const SizedBox(width: 44),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small bordered square button used for the app bar's back / action slots.
class _NeoBarButton extends StatelessWidget {
  const _NeoBarButton({
    required this.icon,
    this.onTap,
    this.color = AppColors.white,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          border: AppBorders.all,
          borderRadius: AppRadii.buttonRadius,
        ),
        child: Icon(icon, color: AppColors.black, size: 22),
      ),
    );
  }
}
