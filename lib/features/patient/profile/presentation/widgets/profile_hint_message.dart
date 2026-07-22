import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ProfileHintMessage extends StatelessWidget {
  const ProfileHintMessage({
    super.key,
    required this.iconData,
    required this.message,
    this.textColor,
  });
  final IconData iconData;
  final String message;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: AppColors.primary, size: 24.sp),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            message,
            style: AppTypography.regular16.copyWith(
              letterSpacing: 0.2,
              height: 1.5,
              color: textColor ?? AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
