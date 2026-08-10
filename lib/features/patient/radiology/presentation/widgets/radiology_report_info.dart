import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class RadiologyReportInfo extends StatelessWidget {
  const RadiologyReportInfo({
    super.key,
    required this.iconData,
    required this.text,
  });
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: AppColors.textPrimaryLight, size: 16.sp),
        SizedBox(width: 8.w),
        Text(
          text,
          style: AppTypography.regular16.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}