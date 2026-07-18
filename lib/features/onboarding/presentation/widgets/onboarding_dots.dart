import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingDots extends StatelessWidget {
  final int count;
  final int currentIndex;

  const OnboardingDots({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) {
          final isActive = i == currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: isActive ? 40.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isActive ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        },
      ),
    );
  }
}
