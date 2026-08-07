import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/profile_setup_chrome.dart';
import 'widgets/ruler_value_picker.dart';

class HeightSelectionScreen extends StatefulWidget {
  const HeightSelectionScreen({super.key});

  @override
  State<HeightSelectionScreen> createState() => _HeightSelectionScreenState();
}

class _HeightSelectionScreenState extends State<HeightSelectionScreen> {
  /// Internal value always stored in centimeters.
  double _cmValue = 173; // ~5'8"
  bool _useInches = true;
  bool _preferNotToSay = false;

  double get _min => _useInches ? 48 : 120; // inches or cm
  double get _max => _useInches ? 84 : 220;

  double get _displayValue {
    if (_useInches) {
      return _cmValue / 2.54;
    }
    return _cmValue;
  }

  void _onUnitChanged(bool useInches) {
    setState(() {
      _useInches = useInches;
      _preferNotToSay = false;
    });
  }

  void _onValueChanged(double value) {
    setState(() {
      _preferNotToSay = false;
      if (_useInches) {
        _cmValue = value * 2.54;
      } else {
        _cmValue = value;
      }
    });
  }

  /// Design shows height like "5.8" meaning 5'8" when inches is selected.
  String _formatDisplay(double value) {
    if (_useInches) {
      final totalInches = value.round();
      final feet = totalInches ~/ 12;
      final inches = totalInches % 12;
      return '$feet.$inches';
    }
    return value.round().toString();
  }

  String _formatTick(double value) {
    if (_useInches) {
      final totalInches = value.round();
      final feet = totalInches ~/ 12;
      final inches = totalInches % 12;
      return '$feet.$inches';
    }
    return value.round().toString();
  }

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
                    const ProfileProgressBar(progress: 0.80),
                    const SizedBox(height: 24),
                    _buildCard(),
                    const SizedBox(height: 16),
                    UnitToggleRow(
                      leftLabel: 'inches',
                      rightLabel: 'cm',
                      isLeftSelected: _useInches,
                      onChanged: _onUnitChanged,
                    ),
                    const SizedBox(height: 28),
                    const ProfileHeadlineBlock(
                      title: "What's your height",
                      subtitle:
                          'To give you a better experience and result\nwe need to know your height',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: ProfileNextButton(
                onTap: () => context.go('/all-done'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 16),
      decoration: BoxDecoration(
        color: ProfileSetupColors.card,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: _preferNotToSay ? 0.35 : 1,
            child: Text(
              _formatDisplay(_displayValue),
              style: GoogleFonts.outfit(
                fontSize: 56,
                fontWeight: FontWeight.w800,
                color: ProfileSetupColors.headline,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 110,
            child: RulerValuePicker(
              key: ValueKey(_useInches ? 'in' : 'cm'),
              min: _min,
              max: _max,
              value: _displayValue.clamp(_min, _max),
              step: 1,
              onChanged: _onValueChanged,
              formatValue: _formatDisplay,
              formatTick: _formatTick,
            ),
          ),
          const SizedBox(height: 8),
          PreferNotToSayLink(
            isSelected: _preferNotToSay,
            onTap: () => setState(() => _preferNotToSay = !_preferNotToSay),
          ),
        ],
      ),
    );
  }
}
