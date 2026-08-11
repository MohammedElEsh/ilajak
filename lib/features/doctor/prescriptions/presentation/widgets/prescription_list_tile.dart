import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/prescriptions/data/models/doctor_prescription_model.dart';

/// Real-data display widget for a `DoctorPrescriptionModel`. The backend
/// only returns a single merged `details` string (no separate
/// medication/dosage/instructions fields on read) — rendered as-is.
class PrescriptionListTile extends StatelessWidget {
  const PrescriptionListTile({super.key, required this.prescription});

  final DoctorPrescriptionModel prescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (prescription.createdAt != null)
            Text(
              prescription.createdAt!,
              style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
            ),
          SizedBox(height: 6.h),
          Text(
            prescription.details,
            style: AppTypography.regular14.copyWith(color: AppColors.textPrimaryLight),
          ),
          if (prescription.doctorName != null) ...[
            SizedBox(height: 6.h),
            Text(
              prescription.doctorName!,
              style: AppTypography.regular12.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
