import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/instagram_stories_row.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final Set<int> _followed = {};

  final List<Map<String, dynamic>> _exploreItems = [
    {
      'title': 'Green Avenue Trail',
      'category': 'Territory Hotspot',
      'distance': '1.2 km away',
      'runners': '24 active',
      'icon': Icons.map_rounded,
      'color': const Color(0xFFEFFAB4),
    },
    {
      'title': 'Zia Colony Sprint',
      'category': 'Speed Zone',
      'distance': '3.5 km away',
      'runners': '18 active',
      'icon': Icons.bolt_rounded,
      'color': const Color(0xFFFDE5D2),
    },
    {
      'title': 'Downtown Loop',
      'category': 'Group Run',
      'distance': '5.0 km away',
      'runners': '42 active',
      'icon': Icons.groups_rounded,
      'color': const Color(0xFFE8F2FD),
    },
    {
      'title': 'Pioneer Hills',
      'category': 'Elevation Challenge',
      'distance': '7.8 km away',
      'runners': '15 active',
      'icon': Icons.terrain_rounded,
      'color': const Color(0xFFF8EEFD),
    },
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
                  // Top Header with Back Button
                  _buildHeader(context),
                  const SizedBox(height: 18),

                  // Big Instagram Stories Row
                  const InstagramStoriesRow(),
                  const SizedBox(height: 24),

                  // Title & Search Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore Nearby',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFAB4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.tune_rounded, color: Color(0xFF2C1948), size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Search Input Box
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFAB4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, color: Color(0xFF2C1948), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF2C1948)),
                            decoration: InputDecoration(
                              hintText: 'Search runners, trails, cells...',
                              hintStyle: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF6B5F7D)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Explore Items Cards Grid / List
                  ...List.generate(_exploreItems.length, (index) {
                    final item = _exploreItems[index];
                    final isFollowing = _followed.contains(index);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: item['color'] as Color,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: const Color(0xFF2C1948),
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2C1948),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${item['category']} · ${item['distance']}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF6B5F7D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Action Button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFollowing) {
                                  _followed.remove(index);
                                } else {
                                  _followed.add(index);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isFollowing ? const Color(0xFF1E7E52) : const Color(0xFF2C1948),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isFollowing ? 'Joined' : 'Explore',
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
                    );
                  }),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Back Button returning to Socials page
        GestureDetector(
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/socials');
            }
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF2C1948),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
              Text(
                'Discover runners & hotspots',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF6B5F7D),
                ),
              ),
            ],
          ),
        ),

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
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
                  'Explore',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.explore_rounded,
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
