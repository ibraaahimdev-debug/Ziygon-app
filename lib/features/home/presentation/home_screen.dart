import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Main Content
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 16.0,
                bottom: 100.0, // Extra padding for floating bottom nav bar
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Greeting, Notification & Profile Avatar
                  _buildHeader(),
                  const SizedBox(height: 18),

                  // Horizontal User Avatars / Stories Row
                  _buildStoriesRow(),
                  const SizedBox(height: 28),

                  // Quick Start Section
                  _buildQuickStartSection(),
                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFFEFECEF), thickness: 1.5),
                  const SizedBox(height: 24),

                  // Territory Section
                  _buildTerritorySection(),
                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFFEFECEF), thickness: 1.5),
                  const SizedBox(height: 24),

                  // Active Challenges Section
                  _buildActiveChallengesSection(),
                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFFEFECEF), thickness: 1.5),
                  const SizedBox(height: 24),

                  // Nearby Routes Section
                  _buildNearbyRoutesSection(),
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

  /// 1. Top Header (Greeting, Notification Bell, User Avatar)
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            // User profile avatar
            Container(
              width: 42,
              height: 42,
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
              width: 42,
              height: 42,
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

  /// 2. Stories / Avatars Horizontal Row
  Widget _buildStoriesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Plus / Add story button
          Container(
            width: 52,
            height: 52,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E0E3B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          // Avatar 1
          _buildAvatarItem(const Color(0xFFFDE5D2), Icons.face_rounded, const Color(0xFFE87A3D)),
          // Avatar 2
          _buildAvatarItem(const Color(0xFFE8F2FD), Icons.face_6_rounded, const Color(0xFF3F82E6)),
          // Avatar 3
          _buildAvatarItem(const Color(0xFFFDEDE8), Icons.face_4_rounded, const Color(0xFFE0523C)),
          // Avatar 4
          _buildAvatarItem(const Color(0xFFF8EEFD), Icons.face_5_rounded, const Color(0xFF933FE6)),
        ],
      ),
    );
  }

  Widget _buildAvatarItem(Color bg, IconData icon, Color iconColor) {
    return Container(
      width: 52,
      height: 52,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF2C1948), width: 2.5),
        color: bg,
      ),
      child: ClipOval(
        child: Icon(icon, color: iconColor, size: 30),
      ),
    );
  }

  /// 3. Quick Start Section
  Widget _buildQuickStartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Start',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1948),
          ),
        ),
        const SizedBox(height: 14),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Tall Running Stadium Card
            Expanded(
              child: Container(
                height: 195,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFAB4),
                  borderRadius: BorderRadius.circular(42),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Inner oval icon container
                    Container(
                      width: 56,
                      height: 84,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F398),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.directions_run_rounded,
                        color: Color(0xFF1E7E52),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Running',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C1948),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Last: 5.2km',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF6B5F7D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Right Column: Stack of Cycling & Walking horizontal cards
            Expanded(
              child: Column(
                children: [
                  // Cycling Card
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFAB4),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F398),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.directions_bike_rounded,
                            color: Color(0xFF1E7E52),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cycling',
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2C1948),
                                ),
                              ),
                              Text(
                                'Last: 12km',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF6B5F7D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Walking Card
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFAB4),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F398),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.directions_walk_rounded,
                            color: Color(0xFF1E7E52),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Walking',
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2C1948),
                                ),
                              ),
                              Text(
                                'Last: 30m',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: const Color(0xFF6B5F7D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 4. Territory Section
  Widget _buildTerritorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Territory',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1948),
          ),
        ),
        const SizedBox(height: 14),

        // Rounded Stadium Map Preview Container
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 155,
            width: double.infinity,
            color: const Color(0xFFE8F1EC),
            child: Stack(
              children: [
                // Vector Map Lines & Territory Overlay
                Positioned.fill(
                  child: CustomPaint(
                    painter: _TerritoryMapPainter(),
                  ),
                ),

                // Location Pin Marker
                Positioned(
                  left: 110,
                  top: 65,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: const Icon(
                      Icons.directions_walk_rounded,
                      color: Color(0xFF2A6EE8),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Action Button: "See your territory" + Purple Play Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFFAB4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'See your territory',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primary,
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
      ],
    );
  }

  /// 5. Active Challenges Section
  Widget _buildActiveChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Challenges',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1948),
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 195,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildChallengeCard(
                icon: Icons.directions_run_rounded,
                title: '30 min\nwalk',
              ),
              const SizedBox(width: 14),
              _buildChallengeCard(
                icon: Icons.directions_bike_rounded,
                title: '5 km\nCycling',
              ),
              const SizedBox(width: 14),
              _buildChallengeCard(
                icon: Icons.directions_run_rounded,
                title: 'Running\n...',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      width: 125,
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(42),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Inner oval icon container
          Container(
            width: 50,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F398),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1E7E52),
              size: 24,
            ),
          ),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1948),
              height: 1.15,
            ),
          ),

          // Circular purple action play button
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primary,
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
    );
  }

  /// 6. Nearby Routes Section
  Widget _buildNearbyRoutesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Routes',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1948),
          ),
        ),
        const SizedBox(height: 14),

        _buildRouteCard(
          title: "Regent's Canal\nLoop",
          distance: '4.8 km',
          difficulty: 'Moderate',
          time: '45 min est.',
          isRiver: false,
        ),
        const SizedBox(height: 12),
        _buildRouteCard(
          title: 'Southbank River\nRun',
          distance: '7.2 km',
          difficulty: 'Flat',
          time: '60 min est.',
          isRiver: true,
        ),
      ],
    );
  }

  Widget _buildRouteCard({
    required String title,
    required String distance,
    required String difficulty,
    required String time,
    required bool isRiver,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Map Thumbnail
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(
                painter: _RouteThumbnailPainter(isRiver: isRiver),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Route Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone_iphone_rounded, size: 13, color: Color(0xFF21804E)),
                    const SizedBox(width: 3),
                    Text(
                      distance,
                      style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF2C1948)),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.show_chart_rounded, size: 13, color: Color(0xFF21804E)),
                    const SizedBox(width: 3),
                    Text(
                      difficulty,
                      style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF2C1948)),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF5A4D6E)),
                    const SizedBox(width: 3),
                    Text(
                      time,
                      style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF5A4D6E)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow Button
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFE2F0B8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF2C1948),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// 7. Floating Pill Bottom Navigation Bar
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
          // Tab 0: Home Pill
          InkWell(
            onTap: () => setState(() => _selectedTab = 0),
            borderRadius: BorderRadius.circular(28),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: _selectedTab == 0 ? const Color(0xFFEFFAB4) : Colors.transparent,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Text(
                    'Home',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1948),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.web_asset_rounded,
                    color: Color(0xFF2C1948),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),

          // Tab 1: Map / Activity
          _buildNavTabItem(1, Icons.directions_walk_rounded, onTap: () => context.push('/map')),
          // Tab 2: Community
          _buildNavTabItem(2, Icons.groups_rounded),
          // Tab 3: Settings
          _buildNavTabItem(3, Icons.settings_rounded),
        ],
      ),
    );
  }

  Widget _buildNavTabItem(int index, IconData icon, {VoidCallback? onTap}) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: onTap ?? () => setState(() => _selectedTab = index),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFFAB4) : const Color(0xFF8B60E6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF2C1948) : Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

/// Draws vector preview map for Territory card
class _TerritoryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFEDE8E3);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final roadPath = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.4, size.height * 0.3)
      ..lineTo(size.width * 0.7, size.height * 0.8)
      ..lineTo(size.width, size.height * 0.7);

    canvas.drawPath(roadPath, roadPaint);

    // Purple Territory Polygon Area
    final territoryPaint = Paint()
      ..color = const Color(0x337B2FF7)
      ..style = PaintingStyle.fill;

    final territoryBorder = Paint()
      ..color = const Color(0xFFE54646)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final polyPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.80, size.height * 0.15)
      ..lineTo(size.width * 0.90, size.height * 0.85)
      ..lineTo(size.width * 0.20, size.height * 0.90)
      ..close();

    canvas.drawPath(polyPath, territoryPaint);
    canvas.drawPath(polyPath, territoryBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Route map thumbnail painter
class _RouteThumbnailPainter extends CustomPainter {
  final bool isRiver;

  _RouteThumbnailPainter({required this.isRiver});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = isRiver ? const Color(0xFFE0F4FB) : const Color(0xFFEFF7E9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final routePaint = Paint()
      ..color = const Color(0xFF1E7E52)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final routePath = Path();
    if (isRiver) {
      routePath.moveTo(10, 50);
      routePath.quadraticBezierTo(30, 20, 65, 40);
    } else {
      routePath.addOval(Rect.fromLTWH(15, 15, 45, 45));
    }

    canvas.drawPath(routePath, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
