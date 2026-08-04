import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single row inside the "Medical Conditions" card (e.g. Allergies,
/// Chronic Diseases). [isFlagged] switches the leading icon + value color
/// from the neutral "None Reported" look to the amber/red flagged look.
class MedicalConditionRow extends StatelessWidget {
  const MedicalConditionRow({
    super.key,
    required this.eyebrowLabel,
    required this.value,
    this.isFlagged = false,
  });

  /// e.g. "ALLERGIES"
  final String eyebrowLabel;

  /// e.g. "None Reported" or "Hypertension (Controlled)"
  final String value;
  final bool isFlagged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrowLabel,
          style: AppTypography.medium12.copyWith(color: context.appColors.textSecondary, letterSpacing: .5),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              isFlagged ? Icons.warning_amber_rounded : Icons.check_circle_outline,
              size: 18.sp,
              color: isFlagged ? context.appColors.error : context.appColors.primary,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(value, style: AppTypography.regular14.copyWith(color: context.appColors.textPrimary)),
            ),
          ],
        ),
      ],
    );
  }
}
