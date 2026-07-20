import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ProfileInformationWidget extends StatelessWidget {
  const ProfileInformationWidget({
    super.key,
    required this.count,
    required this.label,
  });
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106.w,
      height: 76.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey6.withValues(alpha: 0.2),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: AppTypography.semiBold22.copyWith(
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label.tr(),
            style: AppTypography.medium12.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
