import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single info card on Doctor Profile — an icon in a tinted square,
/// an eyebrow label, and a bold value (e.g. "Clinic" / "City Wellness
/// Center"). Pass [trailing] for the "ACTIVE" status pill on License.
class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final Widget icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.primaryLight2,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: icon,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.regular12.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: AppTypography.semiBold16.copyWith(color: AppColors.textPrimaryLight),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
