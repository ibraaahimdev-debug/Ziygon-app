import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/onboarding_service.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/onboarding_item.dart';
import 'widgets/onboarding_card.dart';
import 'widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await OnboardingService.completeOnboarding();
    if (mounted) {
      context.go('/');
    }
  }

  void _nextPage() {
    if (_currentPage < OnboardingItem.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == OnboardingItem.items.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with Skip button
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // Swipeable PageView with 3 Onboarding Cards
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingItem.items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    item: OnboardingItem.items[index],
                  );
                },
              ),
            ),

            // Bottom Navigation Controls
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0, top: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Dots Indicator
                  PageIndicator(
                    count: OnboardingItem.items.length,
                    currentIndex: _currentPage,
                  ),
                  const SizedBox(height: 24),

                  // Circular Purple Arrow Button (or "Get Started" on last card)
                  if (!isLastPage)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _nextPage,
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x337B2FF7),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    )
                  else
                    // Last card: Pill / Circular button with "Get Started" text & arrow
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _nextPage,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x337B2FF7),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
