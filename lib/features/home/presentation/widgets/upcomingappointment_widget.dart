import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';

import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  const UpcomingAppointmentWidget({
    super.key,
  
    required this.title1,
    required this.title2,
    required this.time,
  });
  final String title1;
  final String title2;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight2, 
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                 AppStrings.homeUpcomingAppointment.tr(),
                  style: AppTypography.semiBold14.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                title1,
                style: AppTypography.semiBold18.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              SizedBox(height: 4.h),

              Row(
                children: [
                  Text(
                    title2,
                    style: AppTypography.regular14.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    time,
                    style: AppTypography.regular14.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Image.asset(AppAssets.calenderIcon, width: 48.w, height: 48.h),
        ],
      ),
    );
  }
}
