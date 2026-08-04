import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single row in the "Active Medications" card, e.g.
/// "Lisinopril — 10mg Oral Tablet • Once Daily".
class MedicationListItem extends StatelessWidget {
  const MedicationListItem({
    super.key,
    required this.name,
    required this.detail,
    this.onTap,
  });

  final String name;

  /// e.g. "10mg Oral Tablet • Once Daily"
  final String detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.appColors.background,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.semiBold16.copyWith(color: context.appColors.textPrimary)),
                  SizedBox(height: 2.h),
                  Text(detail, style: AppTypography.regular14.copyWith(color: context.appColors.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.appColors.listTileArrowIcon),
          ],
        ),
      ),
    );
  }
}
