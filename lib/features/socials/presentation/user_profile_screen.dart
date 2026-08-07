import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isFriendAdded = false;

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
                top: 16.0,
                bottom: 100.0,
              ),
              child: Column(
                children: [
                  // Top Controls (Back, Notification Bell, Add Friend)
                  _buildHeader(context),
                  const SizedBox(height: 16),

                  // Large Profile Avatar
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFED8D5),
                      border: Border.all(color: const Color(0xFF2C1948), width: 3),
                    ),
                    child: const ClipOval(
                      child: Center(
                        child: Icon(Icons.face_5_rounded, color: Color(0xFF933FE6), size: 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // User Name & Username
                  Text(
                    'Ibrahim Amjad',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1948),
                    ),
                  ),
                  Text(
                    '@Ibrahim277',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF756F80),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Stats Chips Horizontal Scroll
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildStatChip('5 Cell captured'),
                        const SizedBox(width: 8),
                        _buildStatChip('8 Day streaks'),
                        const SizedBox(width: 8),
                        _buildStatChip('6 Cell Captured'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Joined Date Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFAB4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'joined since 2026 , september',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C1948),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Territory Map Preview Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: const Color(0xFFEAF1ED),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _ProfileTerritoryMapPainter(),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFFAB4),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 6),
                                ],
                              ),
                              child: Text(
                                'Territory 1.8 km covered',
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2C1948),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Posts List
                  _buildPostCard('Hello everyone!\nTerritory issue , someone capturing the flag lets get it pack sharing map.'),
                  const SizedBox(height: 12),
                  _buildPostCard('Hello everyone!\nTerritory issue , someone capturing the flag lets get it pack sharing map.'),
                  const SizedBox(height: 8),

                  // "View all post" Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'View all post',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Floating Bottom Navigation Bar
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: _buildBottomNavigationBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFEFFAB4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2C1948), size: 16),
          ),
        ),
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD6D0DE), width: 1.5),
                color: Colors.white,
              ),
              child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF3B2856), size: 20),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() => _isFriendAdded = !_isFriendAdded);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_isFriendAdded ? 'Friend request sent!' : 'Friend request cancelled'),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isFriendAdded ? const Color(0xFF21804E) : const Color(0xFF2C1948),
                ),
                child: Icon(
                  _isFriendAdded ? Icons.check_rounded : Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1948),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPostCard(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3F82E6),
                ),
                child: const ClipOval(
                  child: Icon(Icons.face_6_rounded, color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Ahmad kaif',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF4A3B63), height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
          _buildNavIconButton(Icons.directions_walk_rounded, () => context.push('/map')),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFFAB4),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                Text(
                  'Socials',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.groups_rounded,
                  color: Color(0xFF2C1948),
                  size: 18,
                ),
              ],
            ),
          ),

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

class _ProfileTerritoryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFEAF1ED);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 65, roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
