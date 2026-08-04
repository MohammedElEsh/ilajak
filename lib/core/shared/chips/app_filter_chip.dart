import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single pill-shaped filter chip (e.g. the "All / Today / New /
/// Returning" row on Doctor Patients, or "All / Date / Client / Patient"
/// on Doctor Schedule). Shared so both screens stay visually identical.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? context.appColors.primary : context.appColors.textSecondary.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: AppTypography.semiBold14.copyWith(
            color: selected ? context.appColors.surface : context.appColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
