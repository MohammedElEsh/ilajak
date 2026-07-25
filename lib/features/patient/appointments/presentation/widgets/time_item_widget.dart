import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class TimeItemWidget extends StatelessWidget {
  const TimeItemWidget({
    super.key,
    this.time,
    required this.isSelected,
    required this.onTap,
  });
  final String? time;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 50.h,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grey5),
        ),
        child: Center(
          child: Text(
            time ?? "09:00 AM",
            style: AppTypography.semiBold16.copyWith(
              color: isSelected
                  ? AppColors.backgroundLight
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ),
    );
  }
}
