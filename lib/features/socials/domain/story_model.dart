import 'package:flutter/material.dart';

class StorySegment {
  final String id;
  final String text;
  final List<Color> gradientColors;
  final IconData? icon;
  final Color? iconColor;
  final String? imagePath;
  final DateTime createdAt;

  StorySegment({
    required this.id,
    required this.text,
    required this.gradientColors,
    this.icon,
    this.iconColor,
    this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class StoryItem {
  final String id;
  final String username;
  final Color avatarBg;
  final IconData avatarIcon;
  final Color avatarIconColor;
  final String timeAgo;
  bool isSeen;
  final bool isUserStory;
  final List<StorySegment> segments;

  StoryItem({
    required this.id,
    required this.username,
    required this.avatarBg,
    required this.avatarIcon,
    required this.avatarIconColor,
    required this.timeAgo,
    this.isSeen = false,
    this.isUserStory = false,
    required this.segments,
  });
}
