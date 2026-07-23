import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class InfoBoxWidget extends StatelessWidget {
  const InfoBoxWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTypography.medium16.copyWith(color: AppColors.fieldLabel),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTypography.semiBold18.copyWith(
              color: AppColors.backgroundDark,
            ),
          ),
        ],
      ),
    );
  }
}
