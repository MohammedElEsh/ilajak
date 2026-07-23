import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

class AppIconOutlineButton extends StatelessWidget {
  const AppIconOutlineButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 48.w,
      height: size ?? 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 24.sp,
        ),
      ),
    );
  }
}