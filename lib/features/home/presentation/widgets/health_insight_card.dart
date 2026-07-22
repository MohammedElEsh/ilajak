import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HealthInsightCard extends StatelessWidget {
  const HealthInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColors.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.homeHealthInsight.tr(),
            style: AppTypography.semiBold18.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),

          SizedBox(height: 14.h),

          Text(
            AppStrings.homeHealthInsightSubtitle.tr(),
            style: AppTypography.regular14.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            height: 42.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceLight.withOpacity(.18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 22.w),
              ),
              child: Text(
                "Learn More",
                style: AppTypography.regular13.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
