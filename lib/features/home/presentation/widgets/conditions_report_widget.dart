import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ConditionsReportWidget extends StatelessWidget {
  const ConditionsReportWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 74.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight2,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedPulseRectangle01,
                size: 30.0,
                color: AppColors.grey2,
                strokeWidth: 1.5,
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTypography.regular13.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  subTitle,
                  style: AppTypography.semiBold18.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            Spacer(),
            HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight02,
              size: 24.0,
              color: AppColors.grey2,
              strokeWidth: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
