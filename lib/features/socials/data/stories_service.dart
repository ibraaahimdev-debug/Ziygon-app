import 'package:flutter/material.dart';
import '../domain/story_model.dart';

class StoriesService {
  static final StoriesService instance = StoriesService._internal();

  factory StoriesService() => instance;

  final ValueNotifier<List<StoryItem>> storiesNotifier = ValueNotifier<List<StoryItem>>([]);

  StoriesService._internal() {
    _initInitialStories();
  }

  void _initInitialStories() {
    storiesNotifier.value = [
      StoryItem(
        id: 'user_story',
        username: 'Your Story',
        avatarBg: const Color(0xFF1E0E3B),
        avatarIcon: Icons.add_rounded,
        avatarIconColor: Colors.white,
        timeAgo: 'Just now',
        isSeen: false,
        isUserStory: true,
        segments: [],
      ),
      StoryItem(
        id: 'story_eishal',
        username: 'Eishal',
        avatarBg: const Color(0xFFFDE5D2),
        avatarIcon: Icons.face_rounded,
        avatarIconColor: const Color(0xFFE87A3D),
        timeAgo: '15m ago',
        isSeen: false,
        segments: [
          StorySegment(
            id: 'seg_e1',
            text: 'Morning 5K run completed! 🏃‍♀️⚡\nFelt super energized around Zia colony!',
            gradientColors: [const Color(0xFFE87A3D), const Color(0xFFF7B731)],
            icon: Icons.directions_run_rounded,
            iconColor: Colors.white,
          ),
          StorySegment(
            id: 'seg_e2',
            text: 'Claimed 2 new territory cells! Who is up for a evening walk? 🌇',
            gradientColors: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
            icon: Icons.map_rounded,
            iconColor: Colors.white,
          ),
        ],
      ),
      StoryItem(
        id: 'story_ibrahim',
        username: 'Ibrahim',
        avatarBg: const Color(0xFFE8F2FD),
        avatarIcon: Icons.face_6_rounded,
        avatarIconColor: const Color(0xFF3F82E6),
        timeAgo: '1h ago',
        isSeen: false,
        segments: [
          StorySegment(
            id: 'seg_i1',
            text: 'Cycling sprint around Green Avenue 🚴‍♂️⚡\nBeat my previous personal record!',
            gradientColors: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
            icon: Icons.directions_bike_rounded,
            iconColor: Colors.white,
          ),
        ],
      ),
      StoryItem(
        id: 'story_ahmad',
        username: 'Ahmad',
        avatarBg: const Color(0xFFFDEDE8),
        avatarIcon: Icons.face_4_rounded,
        avatarIconColor: const Color(0xFFE0523C),
        timeAgo: '2h ago',
        isSeen: false,
        segments: [
          StorySegment(
            id: 'seg_a1',
            text: 'Group meetup with Aura\'s Walkers tomorrow at 7 AM! See you guys there! 👟💪',
            gradientColors: [const Color(0xFFFF416C), const Color(0xFFFF4B2B)],
            icon: Icons.groups_rounded,
            iconColor: Colors.white,
          ),
        ],
      ),
      StoryItem(
        id: 'story_arooba',
        username: 'Arooba',
        avatarBg: const Color(0xFFF8EEFD),
        avatarIcon: Icons.face_5_rounded,
        avatarIconColor: const Color(0xFF933FE6),
        timeAgo: '3h ago',
        isSeen: false,
        segments: [
          StorySegment(
            id: 'seg_ar1',
            text: 'Pioneers Pathfinders lead the weekly leaderboard! 🏆✨',
            gradientColors: [const Color(0xFF833AB4), const Color(0xFFFD1D1D)],
            icon: Icons.emoji_events_rounded,
            iconColor: Colors.white,
          ),
        ],
      ),
    ];
  }

  void addUserStory(String text, List<Color> gradientColors, IconData icon) {
    final currentList = List<StoryItem>.from(storiesNotifier.value);
    final userStoryIndex = currentList.indexWhere((s) => s.isUserStory);

    final newSegment = StorySegment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      gradientColors: gradientColors,
      icon: icon,
      iconColor: Colors.white,
    );

    if (userStoryIndex != -1) {
      final userStory = currentList[userStoryIndex];
      final updatedSegments = List<StorySegment>.from(userStory.segments)..add(newSegment);

      currentList[userStoryIndex] = StoryItem(
        id: userStory.id,
        username: 'Your Story',
        avatarBg: const Color(0xFF2C1948),
        avatarIcon: Icons.face_3_rounded,
        avatarIconColor: const Color(0xFFEFFAB4),
        timeAgo: 'Just now',
        isSeen: false,
        isUserStory: true,
        segments: updatedSegments,
      );
    }
    storiesNotifier.value = currentList;
  }

  void markStorySeen(String storyId) {
    final currentList = List<StoryItem>.from(storiesNotifier.value);
    final index = currentList.indexWhere((s) => s.id == storyId);
    if (index != -1 && !currentList[index].isUserStory) {
      currentList[index].isSeen = true;
      storiesNotifier.value = currentList;
    }
  }
}
