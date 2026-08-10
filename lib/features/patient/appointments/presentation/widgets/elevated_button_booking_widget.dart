import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ElevatedButtonBookingWidget extends StatelessWidget {
  const ElevatedButtonBookingWidget({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.prefiXIcon,
    this.color1,
    this.color2,
  });
  final Widget? prefiXIcon;
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final Color? color1;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color1 ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: AppColors.primary, width: 2.w),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: prefiXIcon ?? const SizedBox.shrink(),
            ),
            Text(
              text,
              style: AppTypography.semiBold16.copyWith(color: color2 ?? AppColors.surfaceLight),
            ),
          ],
        ),
      ),
    );
  }
}
