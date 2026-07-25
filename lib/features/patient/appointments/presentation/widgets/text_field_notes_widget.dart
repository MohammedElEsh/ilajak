import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class TextFieldNotesWidget extends StatelessWidget {
  const TextFieldNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      style: AppTypography.medium16.copyWith(color: AppColors.backgroundDark),
      decoration: InputDecoration(
        hintText: "Describe how you're feeling or any specific symptoms...",
        hintStyle: TextStyle(
          color: AppColors.grey3,
          fontSize: 15.sp,
          height: 1.4.h,
        ),
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: EdgeInsets.all(20.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColors.grey5, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColors.grey5, width: 1.5.w),
        ),
      ),
    );
  }
}
