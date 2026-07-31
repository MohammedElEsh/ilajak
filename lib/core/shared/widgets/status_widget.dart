import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    this.backgroundColor,
    this.textColor,
    required this.title,
    this.textStyle,
  });
  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        title,
        style:
            textStyle ??
            AppTypography.medium12.copyWith(
              color: textColor ?? AppColors.primary,
            ),
      ),
    );
  }
}
