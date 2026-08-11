import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/medical_records/data/models/medical_record_model.dart';

/// Real-data replacement for the old mock `MedicalRecordCard` (which was
/// shaped for fields — title/doctorName/specialty — that don't exist on
/// the actual `GET /medical-records` response). This tile only renders
/// fields the backend actually returns.
class MedicalRecordListTile extends StatelessWidget {
  const MedicalRecordListTile({super.key, required this.record});

  final MedicalRecordModel record;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (record.createdAt != null)
            Text(
              record.createdAt!,
              style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
            ),
          SizedBox(height: 6.h),
          if (record.chronicDiseases != null && record.chronicDiseases!.isNotEmpty) ...[
            Text(
              '${AppStrings.doctorMedicalRecordsChronicDiseases.tr()}: ${record.chronicDiseases}',
              style: AppTypography.regular14.copyWith(color: AppColors.textPrimaryLight),
            ),
            SizedBox(height: 4.h),
          ],
          if (record.allergies != null && record.allergies!.isNotEmpty) ...[
            Text(
              '${AppStrings.doctorMedicalRecordsAllergies.tr()}: ${record.allergies}',
              style: AppTypography.regular14.copyWith(color: AppColors.textPrimaryLight),
            ),
            SizedBox(height: 4.h),
          ],
          Row(
            children: [
              if (record.hasLabResults)
                _Badge(label: AppStrings.doctorMedicalRecordsLabResults.tr()),
              if (record.hasLabResults && record.hasRadiologyResults) SizedBox(width: 8.w),
              if (record.hasRadiologyResults)
                _Badge(label: AppStrings.doctorMedicalRecordsRadiologyResults.tr()),
              if (record.attachments.isNotEmpty) ...[
                SizedBox(width: 8.w),
                Icon(Icons.attach_file, size: 16.sp, color: AppColors.textSecondary),
                Text(
                  '${record.attachments.length}',
                  style: AppTypography.regular12.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight2,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(label, style: AppTypography.regular12.copyWith(color: AppColors.primary)),
    );
  }
}
