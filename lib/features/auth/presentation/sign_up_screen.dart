import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/ziygon_logo_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  static const Color _fieldFill = Color(0xFFF1F5BC);
  static const Color _headline = Color(0xFF2D1B4E);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign up successful!')),
    );
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 8,
              right: -20,
              child: _WaveDecoration(width: 160, height: 90),
            ),
            const Positioned(
              bottom: 90,
              left: -30,
              child: _WaveDecoration(width: 180, height: 70, flip: true),
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        const Center(
                          child: ZiygonLogoWidget(
                            size: 88,
                            showText: true,
                            showTagline: true,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          'Hey,',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _headline,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Let's Sign up",
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: _headline,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _AuthField(
                          controller: _nameController,
                          hint: 'Full Name',
                          fill: _fieldFill,
                        ),
                        const SizedBox(height: 14),
                        _AuthField(
                          controller: _emailController,
                          hint: 'Email address',
                          fill: _fieldFill,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        _AuthField(
                          controller: _passwordController,
                          hint: 'Password',
                          fill: _fieldFill,
                          obscure: true,
                        ),
                        const SizedBox(height: 14),
                        _AuthField(
                          controller: _confirmPasswordController,
                          hint: 'Re-type Password',
                          fill: _fieldFill,
                          obscure: true,
                        ),
                        const SizedBox(height: 28),
                        Container(
                          height: 1,
                          color: const Color(0xFF2D1B4E).withValues(alpha: 0.35),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Continue with google',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Google sign-up coming soon'),
                                ),
                              );
                            },
                            child: const _GoogleMark(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () => context.go('/auth'),
                            child: Text(
                              'Already have an account? Sign in',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _submit,
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x337B2FF7),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Color(0xFFE8FA97),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Color fill;
  final bool obscure;
  final TextInputType? keyboardType;

  const _AuthField({
    required this.controller,
    required this.hint,
    required this.fill,
    this.obscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: const Color(0xFF2D1B4E),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF8A8570),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _GoogleMark extends StatefulWidget {
  const _GoogleMark();

  @override
  State<_GoogleMark> createState() => _GoogleMarkState();
}

class _GoogleMarkState extends State<_GoogleMark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: CustomPaint(
            size: const Size(42, 42),
            painter: _AnimatedGoogleGPainter(progress: _controller.value),
          ),
        );
      },
    );
  }
}

class _AnimatedGoogleGPainter extends CustomPainter {
  final double progress;

  _AnimatedGoogleGPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final stroke = size.width * 0.20;
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Glowing soft background aura animation in Google colors
    final auraColor = Color.lerp(
      const Color(0x334285F4),
      const Color(0x33EA4335),
      progress,
    )!;
    final glowPaint = Paint()
      ..color = auraColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, size.width * 0.46 + (progress * 1.5), glowPaint);

    // Colors matching official rounded Google G mark exactly
    const blueColor = Color(0xFF4285F4);
    const greenColor = Color(0xFF34A853);
    const yellowColor = Color(0xFFFBBC05);
    const redColor = Color(0xFFEA4335);

    final pulseRotation = math.sin(progress * math.pi * 2) * 0.08;

    // 1. Red arc (top-right)
    final redPaint = Paint()
      ..color = redColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -math.pi / 2 + pulseRotation, 1.25, false, redPaint);

    // 2. Yellow arc (bottom-right)
    final yellowPaint = Paint()
      ..color = yellowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -math.pi / 2 + 1.25 + pulseRotation, 1.05, false, yellowPaint);

    // 3. Green arc (bottom)
    final greenPaint = Paint()
      ..color = greenColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -math.pi / 2 + 1.25 + 1.05 + pulseRotation, 1.35, false, greenPaint);

    // 4. Blue arc (left & top)
    final bluePaint = Paint()
      ..color = blueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -math.pi / 2 + 1.25 + 1.05 + 1.35 + pulseRotation, 2.63, false, bluePaint);

    // 5. Horizontal Blue Crossbar with rounded caps matching exact logo
    final barPaint = Paint()
      ..color = blueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final barStart = Offset(size.width * 0.44, size.height * 0.50);
    final barEndLength = size.width * 0.80 + (math.sin(progress * math.pi * 2) * 1.0);
    final barEnd = Offset(barEndLength, size.height * 0.50);
    canvas.drawLine(barStart, barEnd, barPaint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedGoogleGPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _WaveDecoration extends StatelessWidget {
  final double width;
  final double height;
  final bool flip;

  const _WaveDecoration({
    required this.width,
    required this.height,
    this.flip = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flip,
      child: CustomPaint(
        size: Size(width, height),
        painter: _WavePainter(),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D1B4E).withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.1,
        size.width * 0.35,
        size.height * 0.95,
        size.width * 0.55,
        size.height * 0.45,
      )
      ..cubicTo(
        size.width * 0.7,
        size.height * 0.1,
        size.width * 0.85,
        size.height * 0.85,
        size.width,
        size.height * 0.35,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
