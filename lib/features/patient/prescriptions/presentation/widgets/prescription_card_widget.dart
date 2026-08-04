import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/prescriptions/data/models/prescription_model.dart';

class PrescriptionCardWidget extends StatelessWidget {
  final PrescriptionModel prescription;
  final VoidCallback? onRefill;
  final VoidCallback? onView;

  const PrescriptionCardWidget({
    super.key,
    required this.prescription,
    this.onRefill,
    this.onView,
  });

  Color get _statusColor {
    switch (prescription.status) {
      case 'active':
        return AppColors.primary;
      case 'completed':
        return AppColors.labelColor;
      case 'expiring_soon':
        return AppColors.warning;
      case 'expired':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color get _statusBackgroundColor {
    switch (prescription.status) {
      case 'active':
        return AppColors.primaryLight2;
      case 'completed':
        return AppColors.fieldInput;
      case 'expiring_soon':
        return AppColors.lightYellow;
      case 'expired':
        return AppColors.lightRed;
      default:
        return AppColors.lightGray;
    }
  }

  String get _statusText {
    switch (prescription.status) {
      case 'active':
        return AppStrings.prescriptionsStatusActive.tr();
      case 'completed':
        return AppStrings.prescriptionsStatusCompleted.tr();
      case 'expiring_soon':
        return AppStrings.prescriptionsStatusExpiringSoon.tr();
      case 'expired':
        return AppStrings.prescriptionsStatusExpired.tr();
      default:
        return prescription.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey5.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight2,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedPrescriptions,
                  size: 24.sp,
                  color: AppColors.primary,
                  strokeWidth: 1.5,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prescription.doctorName,
                      style: AppTypography.semiBold16.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      prescription.clinicName,
                      style: AppTypography.regular14.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusWidget(
                title: _statusText,
                backgroundColor: _statusBackgroundColor,
                textColor: _statusColor,
                textStyle: AppTypography.bold12.copyWith(color: _statusColor),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.cardInfoBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.prescriptionsMedicines.tr(),
                        style: AppTypography.regular12.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppStrings.prescriptionsMedicinesCount.tr(
                          args: ['${prescription.medicinesCount}'],
                        ),
                        style: AppTypography.semiBold16.copyWith(
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.prescriptionsIssueDate.tr(),
                        style: AppTypography.regular12.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        prescription.datePrescribed,
                        style: AppTypography.semiBold16.copyWith(
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: AppStrings.prescriptionsRefill.tr(),
                  onPressed: onRefill ?? () {},
                  variant: AppButtonVariant.elevated,
                  expanded: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppButton(
                  label: AppStrings.prescriptionsView.tr(),
                  onPressed: onView ?? () {},
                  variant: AppButtonVariant.outlined,
                  expanded: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
