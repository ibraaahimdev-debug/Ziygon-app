import 'package:flutter/material.dart';

class TopRightCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C38CD).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.moveTo(size.width * 0.45, 0);
    path.cubicTo(
      size.width * 0.4, size.height * 0.4,
      size.width * 0.95, size.height * 0.35,
      size.width * 0.7, size.height * 0.75,
    );
    path.cubicTo(
      size.width * 0.55, size.height * 0.95,
      size.width * 0.75, size.height,
      size.width, size.height * 0.85,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomLeftCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C38CD).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.cubicTo(
      size.width * 0.3, size.height * 0.1,
      size.width * 0.4, size.height * 0.9,
      size.width * 0.7, size.height * 0.6,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuthBackgroundCurves extends StatelessWidget {
  final Widget child;

  const AuthBackgroundCurves({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Right Wavy Accent Line
        Positioned(
          top: 0,
          right: 0,
          width: 180,
          height: 240,
          child: CustomPaint(
            painter: TopRightCurvePainter(),
          ),
        ),

        // Bottom Left Wavy Accent Line
        Positioned(
          bottom: 0,
          left: 0,
          width: 180,
          height: 120,
          child: CustomPaint(
            painter: BottomLeftCurvePainter(),
          ),
        ),

        child,
      ],
    );
  }
}
