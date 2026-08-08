import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/stories_service.dart';
import '../../domain/story_model.dart';

class InstagramStoryViewer extends StatefulWidget {
  final List<StoryItem> stories;
  final int initialStoryIndex;

  const InstagramStoryViewer({
    super.key,
    required this.stories,
    this.initialStoryIndex = 0,
  });

  @override
  State<InstagramStoryViewer> createState() => _InstagramStoryViewerState();
}

class _InstagramStoryViewerState extends State<InstagramStoryViewer>
    with SingleTickerProviderStateMixin {
  late int _currentStoryIndex;
  late int _currentSegmentIndex;
  late AnimationController _animController;
  Timer? _timer;
  bool _isLiked = false;
  final TextEditingController _msgController = TextEditingController();

  StoryItem get _currentStory => widget.stories[_currentStoryIndex];
  List<StorySegment> get _segments => _currentStory.segments;
  StorySegment get _currentSegment => _segments[_currentSegmentIndex];

  @override
  void initState() {
    super.initState();
    _currentStoryIndex = widget.initialStoryIndex;
    _currentSegmentIndex = 0;

    // Mark current story as seen in StoriesService
    StoriesService.instance.markStorySeen(_currentStory.id);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextSegment();
      }
    });

    _startTimer();
  }

  void _startTimer() {
    _animController.forward(from: 0.0);
  }

  void _pauseTimer() {
    _animController.stop();
  }

  void _resumeTimer() {
    _animController.forward();
  }

  void _nextSegment() {
    if (_currentSegmentIndex < _segments.length - 1) {
      setState(() {
        _currentSegmentIndex++;
        _isLiked = false;
      });
      _startTimer();
    } else if (_currentStoryIndex < widget.stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentSegmentIndex = 0;
        _isLiked = false;
      });
      StoriesService.instance.markStorySeen(_currentStory.id);
      _startTimer();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousSegment() {
    if (_currentSegmentIndex > 0) {
      setState(() {
        _currentSegmentIndex--;
        _isLiked = false;
      });
      _startTimer();
    } else if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _currentSegmentIndex = widget.stories[_currentStoryIndex].segments.length - 1;
        _isLiked = false;
      });
      _startTimer();
    } else {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _timer?.cancel();
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_segments.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.history_toggle_off_rounded, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              Text(
                'No story segments yet',
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEFFAB4)),
                child: Text('Close', style: GoogleFonts.outfit(color: const Color(0xFF2C1948))),
              ),
            ],
          ),
        ),
      );
    }

    final gradient = _currentSegment.gradientColors;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onLongPressStart: (_) => _pauseTimer(),
          onLongPressEnd: (_) => _resumeTimer(),
          onTapUp: (details) {
            final screenWidth = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < screenWidth * 0.3) {
              _previousSegment();
            } else {
              _nextSegment();
            }
          },
          child: Stack(
            children: [
              // Main Story Content Card with Gradient
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentSegment.icon != null)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                        ),
                        child: Icon(
                          _currentSegment.icon,
                          color: _currentSegment.iconColor ?? Colors.white,
                          size: 54,
                        ),
                      ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        _currentSegment.text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Top Overlay: Progress Bars & User Info Header
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Column(
                  children: [
                    // Segmented Progress Bars
                    Row(
                      children: List.generate(_segments.length, (index) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: AnimatedBuilder(
                              animation: _animController,
                              builder: (context, child) {
                                double progress = 0.0;
                                if (index < _currentSegmentIndex) {
                                  progress = 1.0;
                                } else if (index == _currentSegmentIndex) {
                                  progress = _animController.value;
                                }
                                return FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // User Header Row
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentStory.avatarBg,
                          ),
                          child: Icon(
                            _currentStory.avatarIcon,
                            color: _currentStory.avatarIconColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _currentStory.username,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _currentStory.timeAgo,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Interactive Row (Send message & Like button)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _msgController,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Send message...',
                            hintStyle: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Heart Like Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isLiked ? const Color(0xFFE52E87) : Colors.black.withValues(alpha: 0.35),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Direct Share Button
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.35),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
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
