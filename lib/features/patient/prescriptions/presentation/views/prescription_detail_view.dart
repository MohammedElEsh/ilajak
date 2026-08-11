import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/prescriptions/data/models/prescription_model.dart';

class PrescriptionDetailView extends StatelessWidget {
  const PrescriptionDetailView({super.key, required this.prescription});

  final PrescriptionModel prescription;

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
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppTopBar(
        title: AppStrings.prescriptionsTitle.tr(),
        centerTitle: true,
        leadingWidget: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            _buildHeader(),
            SizedBox(height: 20.h),
            _buildInfoRow(),
            SizedBox(height: 24.h),
            _buildMedicinesSection(),
            SizedBox(height: 24.h),
            _buildDetailsSection(),
            SizedBox(height: 32.h),
            _buildRefillButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLight2,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedPrescriptions,
              size: 28.sp,
              color: AppColors.primary,
              strokeWidth: 1.5,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prescription.doctorName,
                  style: AppTypography.semiBold18.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 4.h),
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
    );
  }

  Widget _buildInfoRow() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
          Container(width: 1, height: 36.h, color: AppColors.grey4),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMedicinesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.prescriptionsDetailMedicinesList.tr(),
          style: AppTypography.semiBold18.copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
        SizedBox(height: 12.h),
        ...List.generate(
          _mockMedicines.length,
          (index) => _buildMedicineCard(_mockMedicines[index]),
        ),
      ],
    );
  }

  Widget _buildMedicineCard(Map<String, String> medicine) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.grey4.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLight2,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedPill,
              size: 20.sp,
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
                  medicine['name'] ?? '',
                  style: AppTypography.semiBold14.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${AppStrings.prescriptionsDosage.tr()}: ${medicine['dosage'] ?? ''}',
                  style: AppTypography.regular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight2,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              medicine['frequency'] ?? '',
              style: AppTypography.medium12.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
          _buildDetailRow(
            iconWidget: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              size: 20.sp,
              color: AppColors.primary,
            ),
            label: AppStrings.prescriptionsDoctor.tr(),
            value: prescription.doctorName,
          ),
          SizedBox(height: 14.h),
          _buildDetailRow(
            iconWidget: HugeIcon(
              icon: HugeIcons.strokeRoundedCalendar01,
              size: 20.sp,
              color: AppColors.primary,
            ),
            label: AppStrings.prescriptionsPrescribed.tr(),
            value: prescription.datePrescribed,
          ),
          SizedBox(height: 14.h),
          _buildDetailRow(
            iconWidget: HugeIcon(
              icon: HugeIcons.strokeRoundedTime02,
              size: 20.sp,
              color: AppColors.primary,
            ),
            label: AppStrings.prescriptionsExpires.tr(),
            value: _calculateExpiryDate(prescription.datePrescribed),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required Widget iconWidget,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        iconWidget,
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            label,
            style: AppTypography.regular14.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTypography.semiBold14.copyWith(
            color: AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildRefillButton() {
    return AppButton(
      label: AppStrings.prescriptionsRefill.tr(),
      onPressed: () {},
      variant: AppButtonVariant.elevated,
      expanded: true,
    );
  }

  String _calculateExpiryDate(String prescribedDate) {
    return '2026-12-31';
  }

  static final List<Map<String, String>> _mockMedicines = [
    {'name': 'Amoxicillin', 'dosage': '500', 'frequency': '3x'},
    {'name': 'Ibuprofen', 'dosage': '200', 'frequency': '2x'},
    {'name': 'Paracetamol', 'dosage': '500', 'frequency': '3x'},
  ];
}
