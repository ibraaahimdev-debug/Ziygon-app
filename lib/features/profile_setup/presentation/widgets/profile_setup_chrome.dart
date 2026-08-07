import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileSetupColors {
  static const Color card = Color(0xFFE8FA97);
  static const Color progressTrack = Color(0xFFE8FA97);
  static const Color progressFill = Color(0xFF4A2C7A);
  static const Color headline = Color(0xFF2D1B4E);
  static const Color body = Color(0xFF6B6280);
  static const Color unitPill = Color(0xFFE4D9FF);
  static const Color ruler = Color(0xFF5B3A9E);
}

class ProfileSetupLogo extends StatelessWidget {
  const ProfileSetupLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/ziygon_logo.png',
          width: 72,
          height: 72,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.bolt_rounded,
            size: 56,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'ZIYGON',
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF141414),
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'TRACK . CONNECT . ACHIEVE',
          style: GoogleFonts.inter(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}

class ProfileProgressBar extends StatelessWidget {
  final double progress;

  const ProfileProgressBar({super.key, required this.progress});

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
                  color: ProfileSetupColors.progressTrack,
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ProfileSetupColors.progressFill,
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
            color: ProfileSetupColors.progressFill,
          ),
        ),
      ],
    );
  }
}

class ProfileNextButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileNextButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: onTap == null
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
    );
  }
}

class PreferNotToSayLink extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const PreferNotToSayLink({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Prefer not to say',
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? AppColors.primary : ProfileSetupColors.headline,
          decoration: TextDecoration.underline,
          decorationColor:
              isSelected ? AppColors.primary : ProfileSetupColors.headline,
        ),
      ),
    );
  }
}

class UnitToggleRow extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final bool isLeftSelected;
  final ValueChanged<bool> onChanged;

  const UnitToggleRow({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.isLeftSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _UnitPill(
            label: leftLabel,
            isSelected: isLeftSelected,
            onTap: () => onChanged(true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _UnitPill(
            label: rightLabel,
            isSelected: !isLeftSelected,
            onTap: () => onChanged(false),
          ),
        ),
      ],
    );
  }
}

class _UnitPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitPill({
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
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ProfileSetupColors.unitPill
                : ProfileSetupColors.unitPill.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                size: 16,
                color: ProfileSetupColors.headline.withValues(
                  alpha: isSelected ? 1 : 0.45,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ProfileSetupColors.headline.withValues(
                    alpha: isSelected ? 1 : 0.55,
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

class ProfileHeadlineBlock extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProfileHeadlineBlock({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: ProfileSetupColors.headline,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ProfileSetupColors.body,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
