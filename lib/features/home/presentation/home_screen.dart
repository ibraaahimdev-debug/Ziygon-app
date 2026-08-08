import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

/// Story data structure for frontend interactive stories
class StoryData {
  final String id;
  final String name;
  final IconData icon;
  final Color avatarBg;
  final Color iconColor;
  final bool isUser;
  bool isSeen;
  final String caption;
  final String stat;
  final String timeAgo;

  StoryData({
    required this.id,
    required this.name,
    required this.icon,
    required this.avatarBg,
    required this.iconColor,
    this.isUser = false,
    this.isSeen = false,
    required this.caption,
    required this.stat,
    required this.timeAgo,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  // Interactive Frontend State
  final List<StoryData> _stories = [
    StoryData(
      id: '0',
      name: 'Your Story',
      icon: Icons.add_rounded,
      avatarBg: const Color(0xFF1E0E3B),
      iconColor: Colors.white,
      isUser: true,
      isSeen: false,
      caption: 'Add your workout update today!',
      stat: '0.0 km',
      timeAgo: 'Just now',
    ),
    StoryData(
      id: '1',
      name: 'Alex',
      icon: Icons.face_rounded,
      avatarBg: const Color(0xFFFDE5D2),
      iconColor: const Color(0xFFE87A3D),
      isSeen: false,
      caption: 'Conquered 5km in Regent Park! 🔥',
      stat: '5.2 km in 24m',
      timeAgo: '2h ago',
    ),
    StoryData(
      id: '2',
      name: 'Sarah',
      icon: Icons.face_6_rounded,
      avatarBg: const Color(0xFFE8F2FD),
      iconColor: const Color(0xFF3F82E6),
      isSeen: false,
      caption: 'Claimed new territory in Downtown! 🏆',
      stat: 'Territory Claimed',
      timeAgo: '4h ago',
    ),
    StoryData(
      id: '3',
      name: 'Liam',
      icon: Icons.face_4_rounded,
      avatarBg: const Color(0xFFFDEDE8),
      iconColor: const Color(0xFFE0523C),
      isSeen: false,
      caption: 'Morning speed run complete 🏃💨',
      stat: '10.1 km',
      timeAgo: '5h ago',
    ),
    StoryData(
      id: '4',
      name: 'Maya',
      icon: Icons.face_5_rounded,
      avatarBg: const Color(0xFFF8EEFD),
      iconColor: const Color(0xFF933FE6),
      isSeen: false,
      caption: 'Sunrise cycling around Southbank 🌅',
      stat: '18.4 km',
      timeAgo: '7h ago',
    ),
    StoryData(
      id: '5',
      name: 'Elena',
      icon: Icons.face_3_rounded,
      avatarBg: const Color(0xFFE4F9EB),
      iconColor: const Color(0xFF1E7E52),
      isSeen: false,
      caption: 'Weekly goal achieved! 100k total 🎉',
      stat: '100% Goal Met',
      timeAgo: '12h ago',
    ),
  ];

  final Map<int, bool> _activeChallengesState = {
    0: false,
    1: false,
    2: false,
  };

  int _notificationCount = 3;

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
                bottom: 100.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Greeting, Notification & Profile Avatar
                  _buildHeader(),
                  const SizedBox(height: 20),

                  // Instagram-Style Large Stories Row
                  _buildInstagramStoriesRow(),
                  const SizedBox(height: 26),

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
            // User profile avatar
            GestureDetector(
              onTap: () => _showProfileDialog(),
              child: Container(
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
            ),
            const SizedBox(width: 10),

            // Notification Bell with Badge
            GestureDetector(
              onTap: () => _showNotificationsDialog(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
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
                  if (_notificationCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE65A4B),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$_notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  /// 2. Instagram-Style Stories Horizontal Row (Enlarged 88px Avatars with Gradient Rings & Subtitles)
  Widget _buildInstagramStoriesRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 128,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _stories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final story = _stories[index];
              return _buildInstagramStoryItem(story, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInstagramStoryItem(StoryData story, int index) {
    const double outerSize = 88.0;
    const double avatarSize = 76.0;

    final isGradientRing = !story.isSeen && !story.isUser;

    return GestureDetector(
      onTap: () {
        setState(() {
          story.isSeen = true;
        });
        _openStoryViewer(index);
      },
      child: SizedBox(
        width: outerSize + 6,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Instagram Gradient Outer Ring or Subtle Border Ring
                Container(
                  width: outerSize,
                  height: outerSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isGradientRing
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFF9CE34),
                              Color(0xFFEE2A7B),
                              Color(0xFF6228D7),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )
                        : null,
                    color: isGradientRing ? null : const Color(0xFFD0C9DB),
                  ),
                ),

                // White Gap Border
                Container(
                  width: outerSize - 6,
                  height: outerSize - 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),

                // Main Avatar Circle
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: story.avatarBg,
                  ),
                  child: Center(
                    child: Icon(
                      story.icon,
                      color: story.iconColor,
                      size: story.isUser ? 38 : 42,
                    ),
                  ),
                ),

                // (+) Badge for User's Story
                if (story.isUser)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B60E6),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // User Name below Story
            Text(
              story.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: story.isSeen ? FontWeight.w600 : FontWeight.w800,
                color: story.isSeen ? const Color(0xFF7A6F8A) : const Color(0xFF2C1948),
              ),
            ),
          ],
        ),
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
              child: GestureDetector(
                onTap: () => _startActivityDialog('Running', Icons.directions_run_rounded, '5.2 km'),
                child: Container(
                  height: 195,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFAB4),
                    borderRadius: BorderRadius.circular(42),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          size: 32,
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
            ),
            const SizedBox(width: 14),

            // Right Column: Cycling & Walking cards
            Expanded(
              child: Column(
                children: [
                  // Cycling Card
                  GestureDetector(
                    onTap: () => _startActivityDialog('Cycling', Icons.directions_bike_rounded, '12 km'),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFFAB4),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE3F398),
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
                  ),
                  const SizedBox(height: 14),

                  // Walking Card
                  GestureDetector(
                    onTap: () => _startActivityDialog('Walking', Icons.directions_walk_rounded, '30m'),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFFAB4),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE3F398),
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

        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 155,
            width: double.infinity,
            color: const Color(0xFFE8F1EC),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _TerritoryMapPainter()),
                ),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => context.push('/map'),
              child: Container(
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
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => context.push('/map'),
              child: Container(
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
                index: 0,
                icon: Icons.directions_run_rounded,
                title: '30 min\nwalk',
              ),
              const SizedBox(width: 14),
              _buildChallengeCard(
                index: 1,
                icon: Icons.directions_bike_rounded,
                title: '5 km\nCycling',
              ),
              const SizedBox(width: 14),
              _buildChallengeCard(
                index: 2,
                icon: Icons.directions_run_rounded,
                title: 'Running\nSprint',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final isDone = _activeChallengesState[index] ?? false;

    return Container(
      width: 125,
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFFDFF5E1) : const Color(0xFFEFFAB4),
        borderRadius: BorderRadius.circular(42),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 65,
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFFC7EBCB) : const Color(0xFFE3F398),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              isDone ? Icons.check_circle_rounded : icon,
              color: const Color(0xFF1E7E52),
              size: 26,
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

          GestureDetector(
            onTap: () {
              setState(() {
                _activeChallengesState[index] = !isDone;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF2C1948),
                  content: Text(
                    !isDone ? 'Challenge marked in progress!' : 'Challenge reset.',
                    style: const TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFF1E7E52) : AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDone ? Icons.check_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 20,
              ),
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
    return GestureDetector(
      onTap: () => _showRouteDetailModal(title, distance, difficulty, time),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFFAB4),
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
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
                      const Icon(
                        Icons.phone_iphone_rounded,
                        size: 13,
                        color: Color(0xFF21804E),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        distance,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.show_chart_rounded,
                        size: 13,
                        color: Color(0xFF21804E),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        difficulty,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: Color(0xFF5A4D6E),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF5A4D6E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.grid_view_rounded, 'Home', null),
          _buildNavItem(1, Icons.directions_walk_rounded, 'Map', () => context.push('/map')),
          _buildNavItem(2, Icons.groups_rounded, 'Social', () => context.push('/socials')),
          _buildNavItem(3, Icons.settings_rounded, 'Settings', () => _showSettingsModal()),
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

  // --- FRONTEND INTERACTIVE MODALS & DIALOGS ---

  /// Opens Instagram Story Viewer dialog with story timer & interactive like/reply
  void _openStoryViewer(int initialIndex) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _InstagramStoryViewer(
        stories: _stories,
        initialIndex: initialIndex,
      ),
    );
  }

  /// Activity live timer modal popup
  void _startActivityDialog(String type, IconData icon, String distance) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LiveActivitySheet(
        type: type,
        icon: icon,
        lastDistance: distance,
      ),
    );
  }

  /// Route detail modal
  void _showRouteDetailModal(String title, String distance, String difficulty, String time) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E0E3B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.replaceAll('\n', ' '),
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  backgroundColor: const Color(0xFFEFFAB4),
                  label: Text('Distance: $distance', style: const TextStyle(color: Color(0xFF2C1948))),
                ),
                const SizedBox(width: 8),
                Chip(
                  backgroundColor: const Color(0xFF8B60E6),
                  label: Text('Terrain: $difficulty', style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Estimated time: $time. Enjoy scenic park trails and territory checkpoints!',
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFFAB4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/territory-tracking');
                },
                child: Text(
                  'Start Route Now',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C1948),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Notifications modal
  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E0E3B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Row(
          children: [
            const Icon(Icons.notifications_active_rounded, color: Color(0xFFEFFAB4)),
            const SizedBox(width: 10),
            Text('Notifications', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationItem('Alex completed 5km challenge!', '10m ago'),
            const Divider(color: Colors.white24),
            _buildNotificationItem('You earned 50 Territory Points!', '1h ago'),
            const Divider(color: Colors.white24),
            _buildNotificationItem('Sarah claimed Regent Park territory!', '3h ago'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _notificationCount = 0);
              Navigator.pop(context);
            },
            child: const Text('Clear All', style: TextStyle(color: Color(0xFFEFFAB4))),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String message, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.fitness_center_rounded, color: Color(0xFFEFFAB4), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: const TextStyle(color: Colors.white, fontSize: 13)),
                Text(time, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Profile Dialog
  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E0E3B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFFFED8D5),
              child: Icon(Icons.face_3_rounded, color: Color(0xFFE65A4B), size: 48),
            ),
            const SizedBox(height: 12),
            Text('Ibrahim Dev', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Territory Rank #1 • Runner', style: GoogleFonts.inter(color: const Color(0xFFEFFAB4), fontSize: 13)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B60E6)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  /// Settings modal preview
  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E0E3B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: GoogleFonts.outfit(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.dark_mode_rounded, color: Color(0xFFEFFAB4)),
              title: Text('Dark Mode', style: TextStyle(color: Colors.white)),
              trailing: Switch(value: true, onChanged: null),
            ),
            const ListTile(
              leading: Icon(Icons.gps_fixed_rounded, color: Color(0xFFEFFAB4)),
              title: Text('GPS High Accuracy', style: TextStyle(color: Colors.white)),
              trailing: Switch(value: true, onChanged: null),
            ),
          ],
        ),
      ),
    );
  }
}

/// Instagram Fullscreen Story Viewer Widget
class _InstagramStoryViewer extends StatefulWidget {
  final List<StoryData> stories;
  final int initialIndex;

  const _InstagramStoryViewer({
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<_InstagramStoryViewer> createState() => _InstagramStoryViewerState();
}

class _InstagramStoryViewerState extends State<_InstagramStoryViewer> with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _animController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() {
        _currentIndex++;
        _isLiked = false;
      });
      _animController.reset();
      _animController.forward();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _isLiked = false;
      });
      _animController.reset();
      _animController.forward();
    } else {
      _animController.reset();
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTapDown: (details) {
            final screenWidth = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < screenWidth / 3) {
              _previousStory();
            } else {
              _nextStory();
            }
          },
          child: Stack(
            children: [
              // Story Main Visual Card
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: story.avatarBg,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: const Color(0xFFEFFAB4), width: 3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(story.icon, size: 96, color: story.iconColor),
                      const SizedBox(height: 20),
                      Text(
                        story.name,
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C1948),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          story.stat,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEFFAB4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '"${story.caption}"',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C1948),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Top Bar: Story Timer Progress Indicators & Header
              Positioned(
                top: 10,
                left: 12,
                right: 12,
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                        widget.stories.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: AnimatedBuilder(
                              animation: _animController,
                              builder: (context, child) {
                                double value = 0.0;
                                if (index < _currentIndex) {
                                  value = 1.0;
                                } else if (index == _currentIndex) {
                                  value = _animController.value;
                                }
                                return LinearProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.white30,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  minHeight: 3,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // User Header Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: story.avatarBg,
                          child: Icon(story.icon, color: story.iconColor, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          story.name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          story.timeAgo,
                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Bar: Instagram-style Like Heart & Reply Bar
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: const Text(
                          'Send message...',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: _isLiked ? Colors.redAccent : Colors.white,
                          size: 26,
                        ),
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
}

/// Live Activity Timer Sheet Widget
class _LiveActivitySheet extends StatefulWidget {
  final String type;
  final IconData icon;
  final String lastDistance;

  const _LiveActivitySheet({
    required this.type,
    required this.icon,
    required this.lastDistance,
  });

  @override
  State<_LiveActivitySheet> createState() => _LiveActivitySheetState();
}

class _LiveActivitySheetState extends State<_LiveActivitySheet> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E0E3B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Icon(widget.icon, size: 56, color: const Color(0xFFEFFAB4)),
          const SizedBox(height: 10),
          Text(
            '${widget.type} Session',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _formatTime(_seconds),
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFEFFAB4),
            ),
          ),
          Text('Active Time', style: GoogleFonts.inter(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 52,
                icon: Icon(
                  _isRunning ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                  color: const Color(0xFFEFFAB4),
                ),
                onPressed: () {
                  setState(() {
                    _isRunning = !_isRunning;
                  });
                },
              ),
              IconButton(
                iconSize: 52,
                icon: const Icon(Icons.stop_circle_rounded, color: Colors.redAccent),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Territory Map Painter
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
    final bgPaint = Paint()
      ..color = isRiver ? const Color(0xFFE0F4FB) : const Color(0xFFEFF7E9);
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
