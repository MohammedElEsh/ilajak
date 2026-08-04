import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
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
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.appColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: context.appColors.primaryLight2,
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
                Text(label, style: AppTypography.regular12.copyWith(color: context.appColors.textSecondary)),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
