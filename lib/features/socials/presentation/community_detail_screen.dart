import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({super.key});

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 18),
                  _buildStoriesRow(context),
                  const SizedBox(height: 24),

                  // Title & Search Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Aura's Walk",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                      const Icon(Icons.search_rounded, color: Color(0xFF2C1948), size: 24),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Announcement Post Card 1
                  _buildAnnouncementCard(
                    author: 'Ahmad kaif',
                    message: 'Hello everyone!\nlets go for walk tomorrow from d ground to green avenue..',
                  ),
                  const SizedBox(height: 12),

                  // Chat Message Bubble 1
                  _buildChatBubble('Ahmad kaif\nHi! we are going 1am with you'),
                  const SizedBox(height: 10),

                  // Chat Message Bubble 2
                  _buildChatBubble('Ahmad kaif\nHi! we are going 1am with you'),
                  const SizedBox(height: 16),

                  // Route Map Post Card
                  _buildRouteMapCard(
                    author: 'Ahmad kaif',
                    message: 'Hello everyone!\nTerritory issue , someone capturing the flag lets get it pack sharing map.',
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
            GestureDetector(
              onTap: () => context.push('/profile'),
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFED8D5),
                ),
                child: const ClipOval(
                  child: Center(
                    child: Icon(Icons.face_3_rounded, color: Color(0xFFE65A4B), size: 28),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
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

  Widget _buildStoriesRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E0E3B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
          _buildAvatarItem(context, const Color(0xFFFDE5D2), Icons.face_rounded, const Color(0xFFE87A3D)),
          _buildAvatarItem(context, const Color(0xFFE8F2FD), Icons.face_6_rounded, const Color(0xFF3F82E6)),
          _buildAvatarItem(context, const Color(0xFFFDEDE8), Icons.face_4_rounded, const Color(0xFFE0523C)),
          _buildAvatarItem(context, const Color(0xFFF8EEFD), Icons.face_5_rounded, const Color(0xFF933FE6)),
        ],
      ),
    );
  }

  Widget _buildAvatarItem(BuildContext context, Color bg, IconData icon, Color iconColor) {
    return GestureDetector(
      onTap: () => context.push('/profile'),
      child: Container(
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
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required String author,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3F82E6),
                ),
                child: const ClipOval(
                  child: Icon(Icons.face_6_rounded, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                author,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF4A3B63), height: 1.35),
          ),
          const SizedBox(height: 12),
          _buildCardActionBar(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF2C1948), height: 1.35),
      ),
    );
  }

  Widget _buildRouteMapCard({
    required String author,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3F82E6),
                ),
                child: const ClipOval(
                  child: Icon(Icons.face_6_rounded, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                author,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF4A3B63), height: 1.35),
          ),
          const SizedBox(height: 12),

          // Pinned Route Map Preview
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 160,
              width: double.infinity,
              color: const Color(0xFFEAF1ED),
              child: CustomPaint(
                painter: _CommunityRouteMapPainter(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildCardActionBar(),
        ],
      ),
    );
  }

  Widget _buildCardActionBar() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFF2C1948),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.check_rounded, color: Colors.white, size: 18),
          Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 18),
          Icon(Icons.info_outline_rounded, color: Colors.white, size: 18),
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

class _CommunityRouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFEAF1ED);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final routePaint = Paint()
      ..color = const Color(0xFF21804E)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(20, 30)
      ..lineTo(size.width * 0.4, size.height * 0.6)
      ..lineTo(size.width - 30, size.height - 20);

    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
