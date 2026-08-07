import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TerritoryCellDetailScreen extends StatefulWidget {
  const TerritoryCellDetailScreen({super.key});

  @override
  State<TerritoryCellDetailScreen> createState() => _TerritoryCellDetailScreenState();
}

class _TerritoryCellDetailScreenState extends State<TerritoryCellDetailScreen> {
  bool _isChallenged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130D1D),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // Dark Futuristic Map Background
            Positioned.fill(
              child: CustomPaint(
                painter: _DarkCellMapPainter(),
              ),
            ),

            // Top Header
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
                          const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'Back',
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
                    'TERRITORY CELL',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFEFFAB4),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),

            // Cell Details & Challenge Card Popup (Floating in upper-center map area)
            Positioned(
              top: 110,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  // Location Pill Callout
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFAB4),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 10),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_rounded, color: Color(0xFF2C1948), size: 18),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cell#482',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2C1948),
                              ),
                            ),
                            Text(
                              'Zia colony',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: const Color(0xFF6B5F7D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Main Cell & Owner Details Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hexagonal Cell Graphic
                      SizedBox(
                        width: 105,
                        height: 105,
                        child: CustomPaint(
                          painter: _HexagonCellPainter(),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Owner Stats Card
                      Container(
                        width: 135,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFAB4).withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black38, blurRadius: 10),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar & Username
                            Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFED8D5),
                                  ),
                                  child: const ClipOval(
                                    child: Icon(Icons.face_5_rounded, color: Color(0xFF933FE6), size: 20),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '@Ibrahim277',
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2C1948),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Stats: Defence, Streak, Roles
                            Text(
                              'Defence : 4',
                              style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF2C1948)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Streak : 5',
                              style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF2C1948)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Roles : 120 pts',
                              style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF2C1948)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Challenge Cell Action Button
                  GestureDetector(
                    onTap: () {
                      setState(() => _isChallenged = !_isChallenged);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isChallenged ? 'Cell Challenge Initiated!' : 'Challenge Cancelled'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                      decoration: BoxDecoration(
                        color: _isChallenged ? const Color(0xFF21804E) : const Color(0xFF7B2FF7),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: _isChallenged ? const Color(0x6621804E) : const Color(0x667B2FF7),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isChallenged ? 'Challenging...' : 'Challenge Cell',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _isChallenged ? Icons.check_circle_rounded : Icons.star_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // "YOUR ZONE" Title
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
                      Positioned(
                        left: 95,
                        top: 2,
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
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B2FF7),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: const Icon(Icons.pause_rounded, color: Colors.white, size: 28),
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
                            ),
                            child: const Icon(Icons.shortcut_rounded, color: Colors.white, size: 26),
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
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavIconButton(Icons.web_asset_rounded, () => context.go('/home')),

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

/// Custom Hexagon Cell Painter
class _HexagonCellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7DA316)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFD4F648)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (3.141592653589793 / 180);
      final x = cx + r * 0.9 * (angle == 0 ? 1 : angle == 3.141592653589793 ? -1 : (i == 1 || i == 5 ? 0.5 : -0.5));
      final y = cy + r * 0.9 * (i == 1 || i == 2 ? 0.866 : i == 4 || i == 5 ? -0.866 : 0);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Dark Cell Map Painter
class _DarkCellMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF130D1D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final gridPaint = Paint()
      ..color = const Color(0xFF231932)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final zonePaint = Paint()
      ..color = const Color(0x667DA316)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height * 0.65), 140, zonePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
