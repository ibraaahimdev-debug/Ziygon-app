import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

                  // Title & Search Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'top Communities',
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

                  // Featured Community Card 1 ("Aura's Walk")
                  _buildFeaturedCommunityCard(
                    title: "Aura's Walk Community",
                    subhead: 'Group Walk & Fitness',
                    desc: 'Join daily walking and running challenges with community members around Green Avenue.',
                    onTap: () => context.push('/community-detail'),
                  ),
                  const SizedBox(height: 16),

                  // Featured Community Card 2
                  _buildFeaturedCommunityCard(
                    title: 'Pioneers Pathfinders',
                    subhead: 'Trail & Exploration',
                    desc: 'Explore new running routes and discover territory cells together with group leaders.',
                    onTap: () => context.push('/community-detail'),
                  ),
                  const SizedBox(height: 12),

                  // "Explore more" Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Explore more',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Your Communities Title
                  Text(
                    'Your communities',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1948),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Joined Communities List
                  _buildYourCommunityItem('A', "Aura's Walkers", 'Active Group'),
                  _buildYourCommunityItem('B', 'Navigator Explorers', 'Pathfinders'),
                  _buildYourCommunityItem('C', 'Pioneers Club', 'Leaderboard'),
                  _buildYourCommunityItem('D', 'Trailblazers Innovators', 'Territory Squad'),
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

  Widget _buildFeaturedCommunityCard({
    required String title,
    required String subhead,
    required String desc,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Graphics Placeholder
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F398),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(Icons.groups_rounded, color: const Color(0xFF1E7E52).withValues(alpha: 0.8), size: 48),
            ),
          ),
          const SizedBox(height: 12),

          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1948),
            ),
          ),
          Text(
            subhead,
            style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF6B5F7D)),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF4A3B63), height: 1.35),
          ),
          const SizedBox(height: 14),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Secondary',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B2FF7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Primary',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYourCommunityItem(String letter, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2C1948),
            ),
            child: Center(
              child: Text(
                letter,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF6B5F7D)),
                ),
              ],
            ),
          ),
          const Icon(Icons.widgets_rounded, color: Color(0xFF2C1948), size: 20),
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
