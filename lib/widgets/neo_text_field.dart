import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Labeled text input with the neo-brutalist border + hard shadow.
class NeoTextField extends StatelessWidget {
  const NeoTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.errorText,
    this.onChanged,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.bodyBold),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: AppBorders.all,
            borderRadius: AppRadii.buttonRadius,
            boxShadow: AppShadows.hard,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: AppText.body,
            cursorColor: AppColors.black,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppText.body.copyWith(color: Colors.black45),
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(prefixIcon, color: AppColors.black),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(errorText!,
              style: AppText.caption.copyWith(
                  color: AppColors.coral, fontWeight: FontWeight.w700)),
        ],
      ],
    );
  }
}
