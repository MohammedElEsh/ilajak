import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.icon,
    required this.title1,
    required this.title2,
  });
  final HugeIcon icon;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: icon,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: AppTypography.medium14.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                title2,
                style: AppTypography.semiBold16.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
