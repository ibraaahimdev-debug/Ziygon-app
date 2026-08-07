import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZiygonLogoWidget extends StatelessWidget {
  final double size;
  final bool showText;
  final bool showTagline;

  const ZiygonLogoWidget({
    super.key,
    this.size = 180,
    this.showText = true,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display exact uploaded Ziygon logo PNG image asset
        Image.asset(
          'assets/images/ziygon_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback vector painter if asset fails to load
            return SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _ZiygonLogoFallbackPainter(),
              ),
            );
          },
        ),

        if (showText) ...[
          SizedBox(height: size * 0.04),
          Text(
            'Z I Y G O N',
            style: GoogleFonts.outfit(
              fontSize: size * 0.15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF141414),
              letterSpacing: 6.0,
            ),
          ),
        ],

        if (showTagline) ...[
          SizedBox(height: size * 0.02),
          Text(
            'TRACK . CONNECT . ACHIEVE',
            style: GoogleFonts.inter(
              fontSize: size * 0.065,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF7B2FF7),
              letterSpacing: 3.5,
            ),
          ),
        ],
      ],
    );
  }
}

class _ZiygonLogoFallbackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final zPaint = Paint()
      ..color = const Color(0xFF7B2FF7)
      ..style = PaintingStyle.fill;

    final zPath = Path();
    zPath.moveTo(w * 0.2, h * 0.25);
    zPath.lineTo(w * 0.8, h * 0.25);
    zPath.lineTo(w * 0.25, h * 0.75);
    zPath.lineTo(w * 0.85, h * 0.75);
    zPath.lineTo(w * 0.85, h * 0.85);
    zPath.lineTo(w * 0.15, h * 0.85);
    zPath.lineTo(w * 0.70, h * 0.35);
    zPath.lineTo(w * 0.2, h * 0.35);
    zPath.close();

    canvas.drawPath(zPath, zPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
