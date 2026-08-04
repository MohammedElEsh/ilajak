import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single stat tile used in the Doctor Home dashboard grid
/// (e.g. "12 Appointments", "03 Pending"...).
///
/// Pass [backgroundColor] for a solid "filled" tile (e.g. the primary
/// "Appointments Today" card). Leave it null for the light, bordered
/// look used by the secondary stats ("Pending", "Completed"...).
class DoctorStatCard extends StatelessWidget {
  const DoctorStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.badgeText,
    this.backgroundColor,
    this.valueColor,
    this.labelColor,
    this.onTap,
  });

  final Widget icon;
  final String value;
  final String label;
  final String? badgeText;
  final Color? backgroundColor;
  final Color? valueColor;
  final Color? labelColor;
  final VoidCallback? onTap;

  bool get _isFilled => backgroundColor != null;

  @override
  Widget build(BuildContext context) {
    final resolvedValueColor =
        valueColor ?? (_isFilled ? context.appColors.surface : context.appColors.textPrimary);
    final resolvedLabelColor =
        labelColor ?? (_isFilled ? context.appColors.surface : context.appColors.textSecondary);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: backgroundColor ?? context.appColors.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: _isFilled ? null : Border.all(color: context.appColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                if (badgeText != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: context.appColors.surface.withValues(alpha: .22),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      badgeText!,
                      style: AppTypography.semiBold14.copyWith(color: resolvedValueColor),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 18.h),
            Text(value, style: AppTypography.bold28.copyWith(color: resolvedValueColor)),
            SizedBox(height: 2.h),
            Text(label, style: AppTypography.regular14.copyWith(color: resolvedLabelColor)),
          ],
        ),
      ),
    );
  }
}
