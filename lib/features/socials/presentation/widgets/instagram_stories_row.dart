import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/stories_service.dart';
import '../../domain/story_model.dart';
import 'instagram_story_viewer.dart';
import 'upload_story_bottom_sheet.dart';

class InstagramStoriesRow extends StatelessWidget {
  const InstagramStoriesRow({super.key});

  void _openUploadStoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const UploadStoryBottomSheet(),
    );
  }

  void _openStoryViewer(BuildContext context, List<StoryItem> stories, int index) {
    final story = stories[index];
    if (story.isUserStory && story.segments.isEmpty) {
      _openUploadStoryModal(context);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InstagramStoryViewer(
          stories: stories,
          initialStoryIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<StoryItem>>(
      valueListenable: StoriesService.instance.storiesNotifier,
      builder: (context, stories, child) {
        return SizedBox(
          height: 106,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return _buildStoryAvatarItem(context, story, stories, index);
            },
          ),
        );
      },
    );
  }

  Widget _buildStoryAvatarItem(
    BuildContext context,
    StoryItem story,
    List<StoryItem> storiesList,
    int index,
  ) {
    final bool isUser = story.isUserStory;
    final bool hasSegments = story.segments.isNotEmpty;
    final bool isUnseen = !story.isSeen && hasSegments;

    return GestureDetector(
      onTap: () => _openStoryViewer(context, storiesList, index),
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Outer Instagram-Style Gradient Ring (if unseen) or Border
                Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isUnseen
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFF99B4A),
                              Color(0xFFE52E87),
                              Color(0xFF8B60E6),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )
                        : null,
                    color: !isUnseen ? const Color(0xFFD6D0DE) : null,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: story.avatarBg,
                      ),
                      child: ClipOval(
                        child: Icon(
                          story.avatarIcon,
                          color: story.avatarIconColor,
                          size: 38,
                        ),
                      ),
                    ),
                  ),
                ),

                // Plus (+) Badge on "Your Story"
                if (isUser)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () => _openUploadStoryModal(context),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1E0E3B),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),

            // Username Label
            SizedBox(
              width: 76,
              child: Text(
                story.username,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: isUnseen ? FontWeight.bold : FontWeight.w500,
                  color: const Color(0xFF2C1948),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
