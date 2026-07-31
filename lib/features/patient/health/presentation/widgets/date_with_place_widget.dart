import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DateWithPlaceWidget extends StatelessWidget {
  const DateWithPlaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HugeIcon(
          icon: HugeIcons.strokeRoundedCalendar03,
          color: AppColors.textPrimaryLight,
          size: 22.sp,
          strokeWidth: 1.5,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Oct 24, 2023 • General Medical Center',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.regular16.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
