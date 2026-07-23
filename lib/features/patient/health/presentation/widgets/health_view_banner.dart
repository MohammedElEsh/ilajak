import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HealthViewBanner extends StatelessWidget {
  const HealthViewBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 176.h,
      decoration: BoxDecoration(
        color: AppColors.primaryLight3,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.labResults.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.surfaceLight),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.monitorYourProgress.tr(),
            style: AppTypography.regular14.copyWith(
              color: AppColors.surfaceLight,
              height: 1.5,
              wordSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
