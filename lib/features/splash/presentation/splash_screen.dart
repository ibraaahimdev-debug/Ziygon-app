import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/onboarding_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/ziygon_logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _proceed(BuildContext context) async {
    final hasSeen = await OnboardingService.hasSeenOnboarding();
    if (context.mounted) {
      if (hasSeen) {
        context.go('/gender');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Centered Ziygon Logo, App Name & Tagline
            const Center(
              child: ZiygonLogoWidget(
                size: 160,
                showText: true,
                showTagline: true,
              ),
            ),
            const Spacer(),

            // Circular Purple Play / Arrow Button at Bottom to proceed
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _proceed(context),
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 56,
                    height: 56,
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
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
