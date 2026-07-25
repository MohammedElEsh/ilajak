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
  });

  final String text;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: AppTypography.semiBold16.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}