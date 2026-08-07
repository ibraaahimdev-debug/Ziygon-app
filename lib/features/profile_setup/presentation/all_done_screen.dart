import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/profile_setup_chrome.dart';

class AllDoneScreen extends StatelessWidget {
  const AllDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const ProfileSetupLogo(),
                    const SizedBox(height: 18),
                    const ProfileProgressBar(progress: 1.0),
                    const SizedBox(height: 48),
                    const _CompletionRing(),
                    const SizedBox(height: 36),
                    Text(
                      "All Done let's Start",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: ProfileSetupColors.headline,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Let's Begin new journey and connect\nwith new peoples like you",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ProfileSetupColors.body,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: ProfileNextButton(
                onTap: () => context.go('/signup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionRing extends StatelessWidget {
  const _CompletionRing();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(220, 220),
            painter: _CompletionRingPainter(),
          ),
          Icon(
            Icons.check_rounded,
            size: 72,
            color: ProfileSetupColors.headline,
          ),
        ],
      ),
    );
  }
}

class _CompletionRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.14;
    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Lime-green segment (~78% of the ring)
    final limePaint = Paint()
      ..color = ProfileSetupColors.card
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Purple segment (~22% of the ring) at the bottom-right
    final purplePaint = Paint()
      ..color = ProfileSetupColors.progressFill
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Start near top-right and sweep clockwise for the lime portion.
    // Flutter arcs: 0 is east, positive is clockwise.
    const limeStart = -math.pi / 2 + 0.15;
    const limeSweep = math.pi * 2 * 0.78;
    const purpleStart = limeStart + limeSweep;
    const purpleSweep = math.pi * 2 * 0.22;

    canvas.drawArc(rect, limeStart, limeSweep, false, limePaint);
    canvas.drawArc(rect, purpleStart, purpleSweep, false, purplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
