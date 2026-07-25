import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

class DateItem extends StatelessWidget {
  const DateItem({super.key, required this.date, required this.isSelected, required this.onTap});

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 64.w,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.grey5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEE').format(date).toUpperCase(),
            style: TextStyle(
              color: isSelected ? AppColors.backgroundLight : AppColors.grey3,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "${date.day}",
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.backgroundLight
                  : AppColors.backgroundDark,
            ),
          ),
        ],
      ),
    ));
  }
}
