import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isSelected ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.dotActive : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
