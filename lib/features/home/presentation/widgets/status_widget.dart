import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    this.image,
    this.title,
    this.analysisName,
    this.analysisResult,
    this.color1,
    this.color2,
  });

  final Widget? image;
  final String? title;
  final String? analysisName;
  final String? analysisResult;
  final Color? color1;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.surfaceLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: image!,
              ),
            SizedBox(height: 8),
            if (image == null) SizedBox(height: 0.h),

            if (title != null)
              Text(
                title!,
                style: AppTypography.semiBold14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            SizedBox(height: 8),

            if (title == null) SizedBox(height: 0.h),

            if (analysisName != null)
              Text(
                analysisName!,
                style: AppTypography.semiBold18.copyWith(
                  color: color1 ?? AppColors.backgroundDark,
                ),
              ),
            SizedBox(height: 8),

            if (analysisName == null) SizedBox(height: 0.h),

            if (analysisResult != null)
              Text(
                analysisResult!,
                style: AppTypography.semiBold14.copyWith(
                  color: color2 ?? AppColors.success,
                ),
              ),
            if (analysisResult == null) SizedBox(height: 0.h),
          ],
        ),
      ),
    );
  }
}
