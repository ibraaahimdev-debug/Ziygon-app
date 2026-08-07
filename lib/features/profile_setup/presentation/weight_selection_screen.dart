import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/profile_setup_chrome.dart';
import 'widgets/ruler_value_picker.dart';

class WeightSelectionScreen extends StatefulWidget {
  const WeightSelectionScreen({super.key});

  @override
  State<WeightSelectionScreen> createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
  bool _useKg = true;
  bool _preferNotToSay = false;
  double _kgValue = 52;

  double get _displayValue => _useKg ? _kgValue : _kgValue * 2.20462;

  double get _min => _useKg ? 30 : 66;
  double get _max => _useKg ? 150 : 330;

  void _onUnitChanged(bool useKg) {
    setState(() {
      _useKg = useKg;
      _preferNotToSay = false;
    });
  }

  void _onValueChanged(double value) {
    setState(() {
      _preferNotToSay = false;
      if (_useKg) {
        _kgValue = value;
      } else {
        _kgValue = value / 2.20462;
      }
    });
  }

  String _formatValue(double value) {
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
                    const ProfileProgressBar(progress: 0.60),
                    const SizedBox(height: 24),
                    _buildCard(),
                    const SizedBox(height: 16),
                    UnitToggleRow(
                      leftLabel: 'kg',
                      rightLabel: 'lb',
                      isLeftSelected: _useKg,
                      onChanged: _onUnitChanged,
                    ),
                    const SizedBox(height: 28),
                    const ProfileHeadlineBlock(
                      title: "What's your weight",
                      subtitle:
                          'To give you a better experience and result\nwe need to know your weight',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: ProfileNextButton(
                onTap: () => context.go('/height'),
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
              _formatValue(_displayValue),
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
              key: ValueKey(_useKg ? 'kg' : 'lb'),
              min: _min,
              max: _max,
              value: _displayValue.clamp(_min, _max),
              step: 1,
              onChanged: _onValueChanged,
              formatValue: _formatValue,
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
