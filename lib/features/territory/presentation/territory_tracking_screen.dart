import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TerritoryTrackingScreen extends StatefulWidget {
  const TerritoryTrackingScreen({super.key});

  @override
  State<TerritoryTrackingScreen> createState() =>
      _TerritoryTrackingScreenState();
}

class _TerritoryTrackingScreenState extends State<TerritoryTrackingScreen> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1ED),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Full Screen Interactive Map Background
            Positioned.fill(
              child: CustomPaint(painter: _LightTerritoryMapPainter()),
            ),

            // Top Right Floating Controls: Profile Avatar & Notification Bell
            Positioned(
              top: 50,
              right: 16,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFED8D5),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: const ClipOval(
                      child: Center(
                        child: Icon(
                          Icons.face_3_rounded,
                          color: Color(0xFFE65A4B),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD6D0DE),
                        width: 1.5,
                      ),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFF3B2856),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Mode Switcher Floating Button (Top Left): "Rival Zone (Dark)"
            Positioned(
              top: 50,
              left: 16,
              child: GestureDetector(
                onTap: () => context.push('/territory-dark-mode'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E0E3B),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFE8FA97),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Rival Zone',
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
            ),

            // Bottom Floating Controls Card & Stats Grid
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

                  // Row 2 Stats: Steps Overlay & Speed Overlay
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatChip(
                          icon: Icons.directions_walk_rounded,
                          text: '6,500',
                          subText: 'Overlay',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatChip(
                          icon: Icons.speed_rounded,
                          text: '12.4 km/h',
                          subText: 'Overlay',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Action Buttons: Pause & Finish/Exit
                  Row(
                    children: [
                      // Pause Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isPaused = !_isPaused),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9D61FF),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x337B2FF7),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isPaused
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Exit / Finish Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9D61FF),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x337B2FF7),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
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
    String? subText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF2C1948), size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
              if (subText != null)
                Text(
                  subText,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF756F80),
                  ),
                ),
            ],
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
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavIconButton(
            Icons.web_asset_rounded,
            () => context.go('/home'),
          ),

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
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

/// Custom Light Territory Map Painter
class _LightTerritoryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE6EDE8);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final canalPaint = Paint()
      ..color = const Color(0xFF6BB5D8)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final canalPath = Path()
      ..moveTo(0, size.height * 0.25)
      ..lineTo(size.width, size.height * 0.05);
    canvas.drawPath(canalPath, canalPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (double i = 0; i < size.height; i += 70) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i + 30), roadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
