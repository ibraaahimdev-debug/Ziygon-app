import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class MapTabScreen extends StatefulWidget {
  const MapTabScreen({super.key});

  @override
  State<MapTabScreen> createState() => _MapTabScreenState();
}

class _MapTabScreenState extends State<MapTabScreen> {
  int _selectedTab = 1; // Map Tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 100.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Greeting, Notification & Profile Avatar
                  _buildHeader(),
                  const SizedBox(height: 22),

                  // Large Stadium Map Card ("Start jogging")
                  _buildStartJoggingCard(context),
                  const SizedBox(height: 18),

                  // Bottom Row: Small Map Preview Card & "Enter in Territory Mod" Card
                  Row(
                    children: [
                      // Small Stadium Map Card with Explore Overlay
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push('/territory-tracking'),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: Container(
                              height: 155,
                              color: const Color(0xFFEAF1ED),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _SmallMapPreviewPainter(),
                                    ),
                                  ),
                                  Container(
                                    width: 108,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.90),
                                      shape: BoxShape.circle,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x1A000000),
                                          blurRadius: 12,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Explore\nMap',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.outfit(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF2C1948),
                                            height: 1.15,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF2C1948),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.explore_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // "Enter in Territory Mod" Card
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push('/territory-tracking'),
                          child: Container(
                            height: 155,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFFAB4),
                              borderRadius: BorderRadius.circular(36),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Enter in\nTerritory\nMod',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2C1948),
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2C1948),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
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

  /// Top Header Widget
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey,',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C1948),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "How's your day going",
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2C1948),
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            // User Avatar
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFED8D5),
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
            const SizedBox(width: 10),

            // Notification Bell
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD6D0DE), width: 1.5),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF3B2856),
                size: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Large Stadium Map Card ("Start jogging")
  Widget _buildStartJoggingCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/territory-tracking'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: Container(
          height: 240,
          width: double.infinity,
          color: const Color(0xFFEAF1ED),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Vector Map Painter Background
              Positioned.fill(
                child: CustomPaint(
                  painter: _StartJoggingMapPainter(),
                ),
              ),

              // Translucent Lime-Yellow Overlay Circle with "Start jogging" text & play icon
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFAB4).withValues(alpha: 0.88),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start\njogging',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2C1948),
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C1948),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.grid_view_rounded, 'Home', () => context.go('/home')),
          _buildNavItem(1, Icons.directions_walk_rounded, 'Map', null),
          _buildNavItem(2, Icons.groups_rounded, 'Social', () => context.push('/socials')),
          _buildNavItem(3, Icons.settings_rounded, 'Settings', null),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, VoidCallback? onTap) {
    final bool isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          setState(() => _selectedTab = index);
        }
      },
      borderRadius: BorderRadius.circular(28),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
            : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFFAB4) : const Color(0xFF8B60E6),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
              const SizedBox(width: 6),
            ],
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2C1948) : Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Map Painter for Large Card
class _StartJoggingMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFEAF1ED);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // Draw grid map lines
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i + 20, size.height), roadPaint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i + 10), roadPaint);
    }

    final poolPaint = Paint()..color = const Color(0xFFBCE3F5);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.75), 18, poolPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Small Map Preview Painter
class _SmallMapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFEAF1ED);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final gridPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i + 15, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i + 10), gridPaint);
    }

    final routePaint = Paint()
      ..color = const Color(0xFF8B60E6)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(20, size.height - 20)
      ..cubicTo(size.width * 0.3, size.height * 0.8, size.width * 0.4, size.height * 0.2, size.width - 20, 20);

    canvas.drawPath(path, routePaint);

    final dotPaint = Paint()..color = const Color(0xFFE65A4B);
    canvas.drawCircle(Offset(size.width - 20, 20), 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
