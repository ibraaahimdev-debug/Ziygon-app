import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final List<Map<String, String>> _requests = [
    {'name': '@Eishal', 'level': 'Lvl 12.'},
    {'name': '@Ibrahim', 'level': 'Lvl 12.'},
    {'name': '@Ahmad', 'level': 'Lvl 12.'},
    {'name': '@Ahmad', 'level': 'Lvl 12.'},
    {'name': '@Arooba', 'level': 'Lvl 12.'},
    {'name': '@Arooba', 'level': 'Lvl 12.'},
  ];

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

                  // Friends Request Title
                  Text(
                    'Friends Request',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1948),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Friends Request Grid (2 columns x 3 rows)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.3,
                    ),
                    itemCount: _requests.length,
                    itemBuilder: (context, index) {
                      final item = _requests[index];
                      return _buildRequestCard(item['name']!, item['level']!, index);
                    },
                  ),
                  const SizedBox(height: 8),

                  // "See more" Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'See more',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Friends Activity Section Title
                  Text(
                    'Friends',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1948),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Friends Activity Status Cards
                  _buildFriendActivityCard(
                    name: 'Amma runs · @amma_runs · 2h',
                    status: 'hi when is plan for walk?',
                  ),
                  _buildFriendActivityCard(
                    name: 'Amma runs · @amma_runs · 2h',
                    status: 'Running now',
                  ),
                  _buildFriendActivityCard(
                    name: 'Amma runs · @amma_runs · 2h',
                    status: 'hi when is plan for walk?',
                  ),
                  _buildFriendActivityCard(
                    name: 'Amma runs · @amma_runs · 2h',
                    status: 'Running now',
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

  Widget _buildRequestCard(String name, String level, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2C1948),
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  level,
                  style: GoogleFonts.inter(fontSize: 9, color: const Color(0xFF6B5F7D)),
                ),
              ],
            ),
          ),

          // Accept / Decline Action Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _requests.removeAt(index));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Accepted $name'), duration: const Duration(milliseconds: 800)),
                  );
                },
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C1948),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 12),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => setState(() => _requests.removeAt(index)),
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C1948),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded, color: Colors.white, size: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFriendActivityCard({
    required String name,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFDE5D2),
            ),
            child: const ClipOval(
              child: Icon(Icons.face_rounded, color: Color(0xFFE87A3D), size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF6B5F7D)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_rounded, size: 10, color: Color(0xFF2C1948)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C1948),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Message Button
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF2C1948),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 18),
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

          // Tab 3: Socials Pill
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
