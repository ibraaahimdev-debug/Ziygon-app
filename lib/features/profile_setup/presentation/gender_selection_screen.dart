import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

enum GenderOption { male, female, preferNotToSay }

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  GenderOption? _selectedGender = GenderOption.male;

  void _select(GenderOption option) {
    setState(() => _selectedGender = option);
  }

  void _continue() {
    context.go('/weight');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildLogo(),
                    const SizedBox(height: 20),
                    const _ProgressBar(progress: 0.20),
                    const SizedBox(height: 28),
                    _buildGenderCard(),
                    const SizedBox(height: 28),
                    Text(
                      'Introduce Yourself',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2D1B4E),
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'To give you a better experience and result\nwe need to know your gender',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B6280),
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
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _selectedGender == null ? null : _continue,
                  borderRadius: BorderRadius.circular(32),
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: _selectedGender == null
                          ? AppColors.primary.withValues(alpha: 0.4)
                          : AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: const [
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

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/ziygon_logo.png',
          width: 56,
          height: 56,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.bolt_rounded,
            size: 48,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'ZIGON',
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
            letterSpacing: 3.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8D6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _GenderOptionColumn(
                  imagePath: 'assets/images/avatar_male.png',
                  label: 'Male',
                  isSelected: _selectedGender == GenderOption.male,
                  onTap: () => _select(GenderOption.male),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _GenderOptionColumn(
                  imagePath: 'assets/images/avatar_female.png',
                  label: 'female',
                  isSelected: _selectedGender == GenderOption.female,
                  onTap: () => _select(GenderOption.female),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () => _select(GenderOption.preferNotToSay),
            child: Text(
              'Prefer not to say',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: _selectedGender == GenderOption.preferNotToSay
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: _selectedGender == GenderOption.preferNotToSay
                    ? AppColors.primary
                    : const Color(0xFF3A3148),
                decoration: _selectedGender == GenderOption.preferNotToSay
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;

  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 8,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xFFFFF3B0),
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A2C7A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$percent%',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4A2C7A),
          ),
        ),
      ],
    );
  }
}

class _GenderOptionColumn extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOptionColumn({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 118,
            height: 118,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.55)
                    : Colors.transparent,
                width: 3,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFEDE8F5),
                  child: Icon(
                    label.toLowerCase().startsWith('m')
                        ? Icons.person_rounded
                        : Icons.person_outline_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        _GenderPillButton(
          label: label,
          isSelected: isSelected,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _GenderPillButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderPillButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFE4D9FF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFE4D9FF)
                  : const Color(0xFF2D1B4E),
              width: 1.4,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : const Color(0xFF2D1B4E).withValues(alpha: 0.08),
                ),
                child: Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFF2D1B4E),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D1B4E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
