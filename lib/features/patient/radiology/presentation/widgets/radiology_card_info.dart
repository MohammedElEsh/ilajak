import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/download_icon_button.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/radiology_report_info.dart';
import 'package:ilajak/features/patient/radiology/presentation/widgets/view_report_button.dart';

class RadiologyCardInfo extends StatelessWidget {
  const RadiologyCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadiusDirectional.circular(20.r),
          border: Border.all(color: AppColors.surfaceLight, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.surfaceDark.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(16.r),
                  child: Image.asset(
                    AppAssets.radiologyImage,
                    width: 96.w,
                    height: 96.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status And Date
                    Row(
                      children: [
                        const StatusWidget(
                          title: "Completed",
                          backgroundColor: AppColors.primaryLight2,
                          textColor: AppColors.primary,
                        ),
                        SizedBox(width: 24.w),
                        Text(
                          "Oct 25,2024",
                          style: AppTypography.regular14.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "MRI Brain (Contrast)",
                      style: AppTypography.semiBold18.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    const RadiologyReportInfo(
                      iconData: Icons.local_hospital_outlined,
                      text: "Dr. Sarah Jenkins",
                    ),
                    SizedBox(height: 4.h),
                    const RadiologyReportInfo(
                      iconData: Icons.location_on_outlined,
                      text: "City Diagnostic Center",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                // 1. Elevated Button (View Report)
                ViewReportButton(onPressed: () {}),
                const SizedBox(width: 12),
                // 2. Outlined Button (Download Icon + Download)
                DownloadIconButton(onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
