import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingArtWidget extends StatelessWidget {
  final int cardIndex;

  const OnboardingArtWidget({
    super.key,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Background pale yellow-green container shape
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accentShape,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),

            // Large pale yellow-green / white letterform "Z"
            Positioned.fill(
              child: CustomPaint(
                painter: _LetterZPainter(),
              ),
            ),

            // Card artwork (0: Runner Photo, 1: Road Bike Photo, 2: Athletic Shoe Photo)
            if (cardIndex == 0)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/runner.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return CustomPaint(
                        painter: _OnboardingSubjectPainter(cardIndex: 0),
                      );
                    },
                  ),
                ),
              )
            else if (cardIndex == 1)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/bike.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return CustomPaint(
                        painter: _OnboardingSubjectPainter(cardIndex: 1),
                      );
                    },
                  ),
                ),
              )
            else if (cardIndex == 2)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/shoe.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return CustomPaint(
                        painter: _OnboardingSubjectPainter(cardIndex: 2),
                      );
                    },
                  ),
                ),
              )
            else
              Positioned.fill(
                child: CustomPaint(
                  painter: _OnboardingSubjectPainter(cardIndex: cardIndex),
                ),
              ),

            // Dynamic purple motion speed lines
            Positioned.fill(
              child: CustomPaint(
                painter: _MotionLinesPainter(),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Draws the large background letterform "Z" in pale yellow-green accent style
class _LetterZPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Z',
        style: TextStyle(
          fontSize: size.height * 0.95,
          fontWeight: FontWeight.w900,
          fontFamily: 'Roboto',
          color: Colors.white.withValues(alpha: 0.55),
          height: 0.9,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final offset = Offset(
      (size.width - textPainter.width) / 2 - size.width * 0.05,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws vector graphics fallback for Bike and Shoe
class _OnboardingSubjectPainter extends CustomPainter {
  final int cardIndex;

  _OnboardingSubjectPainter({required this.cardIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (cardIndex == 1) {
      _drawBikeFallback(canvas, w, h);
    } else if (cardIndex == 2) {
      _drawShoeFallback(canvas, w, h);
    }
  }

  void _drawBikeFallback(Canvas canvas, double w, double h) {
    final framePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.038
      ..strokeCap = StrokeCap.round;

    final wheelPaint = Paint()
      ..color = const Color(0xFF221C2B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.05;

    final rearCenter = Offset(w * 0.25, h * 0.58);
    final frontCenter = Offset(w * 0.75, h * 0.58);
    canvas.drawCircle(rearCenter, w * 0.20, wheelPaint);
    canvas.drawCircle(frontCenter, w * 0.20, wheelPaint);

    final bottomBracket = Offset(w * 0.44, h * 0.58);
    final seatPostTop = Offset(w * 0.40, h * 0.35);
    final headTubeTop = Offset(w * 0.65, h * 0.32);

    final framePath = Path()
      ..moveTo(rearCenter.dx, rearCenter.dy)
      ..lineTo(seatPostTop.dx, seatPostTop.dy)
      ..lineTo(bottomBracket.dx, bottomBracket.dy)
      ..close()
      ..moveTo(bottomBracket.dx, bottomBracket.dy)
      ..lineTo(headTubeTop.dx, headTubeTop.dy)
      ..lineTo(seatPostTop.dx, seatPostTop.dy)
      ..close()
      ..moveTo(headTubeTop.dx, headTubeTop.dy)
      ..lineTo(frontCenter.dx, frontCenter.dy);

    canvas.drawPath(framePath, framePaint);
  }

  void _drawShoeFallback(Canvas canvas, double w, double h) {
    final shoeBody = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final solePaint = Paint()
      ..color = const Color(0xFF191124)
      ..style = PaintingStyle.fill;

    final shoePath = Path();
    shoePath.moveTo(w * 0.18, h * 0.45);
    shoePath.quadraticBezierTo(w * 0.25, h * 0.35, w * 0.40, h * 0.32);
    shoePath.quadraticBezierTo(w * 0.55, h * 0.35, w * 0.72, h * 0.50);
    shoePath.quadraticBezierTo(w * 0.88, h * 0.62, w * 0.82, h * 0.72);
    shoePath.lineTo(w * 0.20, h * 0.72);
    shoePath.quadraticBezierTo(w * 0.14, h * 0.60, w * 0.18, h * 0.45);
    shoePath.close();

    canvas.drawPath(shoePath, shoeBody);

    final solePath = Path();
    solePath.moveTo(w * 0.15, h * 0.72);
    solePath.lineTo(w * 0.85, h * 0.72);
    solePath.lineTo(w * 0.80, h * 0.80);
    solePath.lineTo(w * 0.20, h * 0.80);
    solePath.close();
    canvas.drawPath(solePath, solePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Motion speed lines (purple dashes on left and right)
class _MotionLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Left motion dashes
    canvas.drawLine(Offset(w * 0.02, h * 0.30), Offset(w * 0.08, h * 0.30), linePaint);
    canvas.drawLine(Offset(w * 0.05, h * 0.35), Offset(w * 0.12, h * 0.35), linePaint);
    canvas.drawLine(Offset(w * 0.01, h * 0.65), Offset(w * 0.07, h * 0.65), linePaint);

    // Right motion dashes
    canvas.drawLine(Offset(w * 0.88, h * 0.25), Offset(w * 0.95, h * 0.25), linePaint);
    canvas.drawLine(Offset(w * 0.90, h * 0.70), Offset(w * 0.98, h * 0.70), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
