import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/auth_background_curves.dart';
import '../../../core/widgets/ziygon_logo_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    final newPass = _newPasswordController.text.trim();
    final retypePass = _retypePasswordController.text.trim();

    if (newPass.isEmpty || retypePass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both password fields', style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFFE0523C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (newPass != retypePass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match! Please check and try again.', style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFFE0523C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password reset successfully! Please sign in. ✨', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E7E52),
        behavior: SnackBarBehavior.floating,
      ),
    );

    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AuthBackgroundCurves(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Top Header Logo
                const Center(
                  child: ZiygonLogoWidget(
                    size: 90,
                    showText: true,
                    showTagline: true,
                  ),
                ),
                const SizedBox(height: 50),

                // Title Text
                Text(
                  'Forget your\npassword?\nlet\'s Recover',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2C1948),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),

                // New Password Pill Input Box
                Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFAB4),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF2C1948),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'New password',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF6B5F7D),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Re-type Password Pill Input Box
                Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFAB4),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _retypePasswordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF2C1948),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Re-type Password',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF6B5F7D),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Continue with google
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Continue with google',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF6B5F7D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'G',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4285F4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Bottom Circular Purple Action Button
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _resetPassword,
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8536FF),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x338536FF),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
