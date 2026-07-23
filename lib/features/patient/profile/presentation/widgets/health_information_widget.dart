import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HealthInformationWidget extends StatelessWidget {
  const HealthInformationWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.value,
  });
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circle avatar with icon
          CircleAvatar(
            radius: 24.r,
            backgroundColor: iconBgColor,
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: AppTypography.medium12.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 8.h),
          // Verified status
          value,
        ],
      ),
    );
  }
}
