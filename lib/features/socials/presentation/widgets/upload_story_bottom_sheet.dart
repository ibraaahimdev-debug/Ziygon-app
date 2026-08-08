import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/stories_service.dart';

class UploadStoryBottomSheet extends StatefulWidget {
  const UploadStoryBottomSheet({super.key});

  @override
  State<UploadStoryBottomSheet> createState() => _UploadStoryBottomSheetState();
}

class _UploadStoryBottomSheetState extends State<UploadStoryBottomSheet> {
  final TextEditingController _textController = TextEditingController();

  int _selectedGradientIndex = 0;
  int _selectedIconIndex = 0;

  final List<List<Color>> _gradientPresets = [
    [const Color(0xFF833AB4), const Color(0xFFFD1D1D), const Color(0xFFFCB045)],
    [const Color(0xFFE87A3D), const Color(0xFFF7B731)],
    [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    [const Color(0xFF4E54C8), const Color(0xFF8F94FB)],
    [const Color(0xFFFF416C), const Color(0xFFFF4B2B)],
  ];

  final List<IconData> _iconPresets = [
    Icons.directions_run_rounded,
    Icons.directions_bike_rounded,
    Icons.map_rounded,
    Icons.groups_rounded,
    Icons.emoji_events_rounded,
    Icons.auto_awesome_rounded,
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitStory() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a caption for your story!', style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFFE0523C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    StoriesService.instance.addUserStory(
      text,
      _gradientPresets[_selectedGradientIndex],
      _iconPresets[_selectedIconIndex],
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Story posted successfully! ✨', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E7E52),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeGradient = _gradientPresets[_selectedGradientIndex];
    final activeIcon = _iconPresets[_selectedIconIndex];

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Create Story',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1948),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, color: Color(0xFF2C1948)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Live Story Preview Card
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: activeGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: activeGradient.first.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(activeIcon, color: Colors.white, size: 36),
                const SizedBox(height: 10),
                Text(
                  _textController.text.isEmpty
                      ? 'Type your workout status or story below...'
                      : _textController.text,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Text Field Input
          TextField(
            controller: _textController,
            onChanged: (_) => setState(() {}),
            maxLines: 2,
            style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF2C1948)),
            decoration: InputDecoration(
              hintText: 'Share what you achieved today...',
              hintStyle: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF6F4F8),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Background Colors Selection Title
          Text(
            'Theme Gradient',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1948),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_gradientPresets.length, (index) {
                final colors = _gradientPresets[index];
                final isSelected = index == _selectedGradientIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGradientIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: colors),
                      border: isSelected
                          ? Border.all(color: const Color(0xFF2C1948), width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                        : null,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          // Icon Selection Title
          Text(
            'Activity Icon',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1948),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_iconPresets.length, (index) {
                final icon = _iconPresets[index];
                final isSelected = index == _selectedIconIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIconIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2C1948) : const Color(0xFFF6F4F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? const Color(0xFFEFFAB4) : const Color(0xFF2C1948),
                      size: 22,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),

          // Share Story Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _submitStory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C1948),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                elevation: 0,
              ),
              child: Text(
                'Share Story ✨',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEFFAB4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
