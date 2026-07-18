import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';

class OnboardingHeader extends StatelessWidget {
  final int current;
  final int total;
  final bool showSkip;
  final VoidCallback? onSkip;

  const OnboardingHeader({
    super.key,
    required this.current,
    required this.total,
    required this.showSkip,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedStethoscope,
                color: theme.colorScheme.primary,
                size: 32.sp,
              ),
              Text(
                '3ilajak',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          if (showSkip)
            InkWell(
              onTap: onSkip,
              child: Text(
                AppStrings.onboardingSkip.tr(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
