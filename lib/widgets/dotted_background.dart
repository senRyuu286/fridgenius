import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Cream background with a subtle green dotted pattern. Wrap a screen body.
class DottedBackground extends StatelessWidget {
  const DottedBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cream,
      child: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: _DotPainter())),
          child,
        ],
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  const _DotPainter();

  static const double _spacing = 26;
  static const double _radius = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.dot;
    for (double y = _spacing / 2; y < size.height; y += _spacing) {
      for (double x = _spacing / 2; x < size.width; x += _spacing) {
        canvas.drawCircle(Offset(x, y), _radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
