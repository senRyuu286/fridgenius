import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum NeoButtonVariant { primary, secondary, light }

/// Neo-brutalist button. On press it shifts into its hard shadow.
class NeoButton extends StatefulWidget {
  const NeoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = NeoButtonVariant.primary,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final NeoButtonVariant variant;
  final IconData? icon;
  final bool expand;

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _pressed = false;

  Color get _background {
    switch (widget.variant) {
      case NeoButtonVariant.primary:
        return AppColors.coral;
      case NeoButtonVariant.secondary:
        return AppColors.gold;
      case NeoButtonVariant.light:
        return AppColors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final pressed = _pressed && enabled;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: GestureDetector(
        onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 40),
          transform: Matrix4.translationValues(
            pressed ? AppShadows.offset.dx : 0,
            pressed ? AppShadows.offset.dy : 0,
            0,
          ),
          width: widget.expand ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: _background,
            border: AppBorders.all,
            borderRadius: AppRadii.buttonRadius,
            boxShadow: pressed ? AppShadows.none : AppShadows.hard,
          ),
          child: Row(
            mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: AppColors.black, size: 20),
                const SizedBox(width: 8),
              ],
              Text(widget.label, style: AppText.button),
            ],
          ),
        ),
      ),
    );
  }
}
