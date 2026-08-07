import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TerritoryDarkModeScreen extends StatefulWidget {
  const TerritoryDarkModeScreen({super.key});

  @override
  State<TerritoryDarkModeScreen> createState() => _TerritoryDarkModeScreenState();
}

class _TerritoryDarkModeScreenState extends State<TerritoryDarkModeScreen> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130D1D),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Dark Futuristic Map Background with Territory Zones
            Positioned.fill(
              child: GestureDetector(
                onTap: () => context.push('/territory-cell-detail'),
                child: CustomPaint(
                  painter: _DarkTerritoryMapPainter(),
                ),
              ),
            ),

            // Top Header: "RIVAL ZONE" Title & Mode Switcher Button
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C1948),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF7B2FF7), width: 1.2),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.wb_sunny_outlined, color: Color(0xFFEFFAB4), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Light Mode',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'RIVAL ZONE',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFE52E87),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),

            // "YOUR ZONE" Floating Label
            Positioned(
              bottom: 270,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'YOUR ZONE',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFD4F648),
                    letterSpacing: 2.5,
                  ),
                ),
              ),
            ),

            // Bottom Stats Grid & Action Controls Card
            Positioned(
              left: 20,
              right: 20,
              bottom: 90,
              child: Column(
                children: [
                  // Row 1 Stats: Clock & Calories
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatChip(
                          icon: Icons.timer_outlined,
                          text: '13:01:00',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatChip(
                          icon: Icons.local_fire_department_outlined,
                          text: '340 kcal',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Row 2 Stats: Steps Overlay & Speed Overlay with Glowing Beacon Pin
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatChip(
                              icon: Icons.directions_walk_rounded,
                              text: '6,500',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatChip(
                              icon: Icons.speed_rounded,
                              text: '12.4 km/h',
                            ),
                          ),
                        ],
                      ),

                      // Glowing Green Beacon Marker on top of steps chip
                      Positioned(
                        left: 95,
                        top: 2,
                        child: GestureDetector(
                          onTap: () => context.push('/territory-cell-detail'),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD4F648),
                              boxShadow: const [
                                BoxShadow(color: Color(0xFFD4F648), blurRadius: 14, spreadRadius: 3),
                              ],
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Action Buttons: Pause & Exit
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isPaused = !_isPaused),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B2FF7),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: const [
                                BoxShadow(color: Color(0x667B2FF7), blurRadius: 12, offset: Offset(0, 4)),
                              ],
                            ),
                            child: Icon(
                              _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B2FF7),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: const [
                                BoxShadow(color: Color(0x667B2FF7), blurRadius: 12, offset: Offset(0, 4)),
                              ],
                            ),
                            child: const Icon(
                              Icons.shortcut_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Floating Pill Bottom Navigation Bar
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: _buildBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF2C1948), size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1948),
            ),
          ),
        ],
      ),
    );
  }

  /// Floating Pill Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF584C6A),
        borderRadius: BorderRadius.circular(36),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavIconButton(Icons.web_asset_rounded, () => context.go('/home')),

          // Map Tab Pill (Selected)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFFAB4),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                Text(
                  'Map',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.directions_walk_rounded,
                  color: Color(0xFF2C1948),
                  size: 18,
                ),
              ],
            ),
          ),

          _buildNavIconButton(Icons.groups_rounded, null),
          _buildNavIconButton(Icons.settings_rounded, null),
        ],
      ),
    );
  }

  Widget _buildNavIconButton(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFF8B60E6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

/// Custom Dark Territory Map Painter
class _DarkTerritoryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF130D1D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Subtle Grid Lines
    final gridPaint = Paint()
      ..color = const Color(0xFF231932)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // 1. RIVAL ZONE (Dark Magenta Polygon at Top Right)
    final rivalPaint = Paint()
      ..color = const Color(0x66E52E87)
      ..style = PaintingStyle.fill;

    final rivalPath = Path()
      ..moveTo(size.width * 0.55, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.28)
      ..lineTo(size.width * 0.65, size.height * 0.28)
      ..close();
    canvas.drawPath(rivalPath, rivalPaint);

    // 2. Dark Teal Polygon Territory (Middle)
    final tealPaint = Paint()
      ..color = const Color(0x441E6668)
      ..style = PaintingStyle.fill;

    final tealPath = Path()
      ..moveTo(size.width * 0.50, size.height * 0.32)
      ..lineTo(size.width * 0.75, size.height * 0.35)
      ..lineTo(size.width * 0.72, size.height * 0.45)
      ..lineTo(size.width * 0.48, size.height * 0.42)
      ..close();
    canvas.drawPath(tealPath, tealPaint);

    // 3. YOUR ZONE (Glowing Lime Green Territory Polygon at Bottom Center)
    final yourZonePaint = Paint()
      ..color = const Color(0x887DA316)
      ..style = PaintingStyle.fill;

    final yourZonePath = Path()
      ..moveTo(size.width * 0.20, size.height * 0.50)
      ..lineTo(size.width * 0.85, size.height * 0.52)
      ..lineTo(size.width * 0.90, size.height * 0.85)
      ..lineTo(size.width * 0.15, size.height * 0.85)
      ..close();
    canvas.drawPath(yourZonePath, yourZonePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
