import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single appointment card in the Doctor "Schedule" (daily agenda) list.
///
/// The action row is data-driven: pass whichever callbacks apply to this
/// appointment and the card lays itself out to match —
/// e.g. Confirm+Complete (+Cancel/View Details below) for a confirmed slot,
/// or Confirm+Reschedule for a pending one.
class DoctorScheduleAppointmentCard extends StatelessWidget {
  const DoctorScheduleAppointmentCard({
    super.key,
    required this.patientName,
    required this.typeLabel,
    required this.timeLabel,
    required this.statusLabel,
    this.imageUrl,
    this.isPending = false,
    this.onConfirm,
    this.onComplete,
    this.onCancel,
    this.onReschedule,
    this.onViewDetails,
  });

  final String patientName;

  /// e.g. "Consultation", "Follow-up", "Check-up"
  final String typeLabel;

  /// e.g. "9:30 AM"
  final String timeLabel;

  /// e.g. "Confirmed" / "Pending"
  final String statusLabel;
  final String? imageUrl;
  final bool isPending;

  final VoidCallback? onConfirm;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final statusBg = isPending
        ? AppColors.textSecondary.withValues(alpha: .12)
        : AppColors.primary;
    final statusFg = isPending ? AppColors.textSecondary : AppColors.surfaceLight;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: AppColors.secondary,
                backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? Icon(Icons.person_outline, color: AppColors.primary, size: 24.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  patientName,
                  style: AppTypography.semiBold16.copyWith(color: AppColors.textPrimaryLight),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  statusLabel,
                  style: AppTypography.regular12.copyWith(color: statusFg),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(typeLabel, style: AppTypography.regular14.copyWith(color: AppColors.textSecondary)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CircleAvatar(radius: 2.r, backgroundColor: AppColors.textSecondary),
              ),
              Text(
                timeLabel,
                style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          if (onConfirm != null || onComplete != null || onReschedule != null) ...[
            SizedBox(height: 14.h),
            const Divider(height: 1, color: AppColors.divider),
            SizedBox(height: 14.h),
            Row(
              children: [
                if (onConfirm != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        AppStrings.doctorScheduleConfirm.tr(),
                        style: AppTypography.semiBold14.copyWith(color: AppColors.surfaceLight),
                      ),
                    ),
                  ),
                if (onComplete != null) ...[
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onComplete,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        AppStrings.doctorScheduleComplete.tr(),
                        style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                ] else if (onReschedule != null) ...[
                  TextButton(
                    onPressed: onReschedule,
                    child: Text(
                      AppStrings.doctorScheduleReschedule.tr(),
                      style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ],
            ),
          ],
          if (onCancel != null)
            Center(
              child: TextButton(
                onPressed: onCancel,
                child: Text(
                  AppStrings.doctorScheduleCancel.tr(),
                  style: AppTypography.semiBold14.copyWith(color: AppColors.error),
                ),
              ),
            ),
          if (onViewDetails != null)
            Center(
              child: TextButton(
                onPressed: onViewDetails,
                child: Text(
                  AppStrings.doctorScheduleViewDetails.tr(),
                  style: AppTypography.semiBold14.copyWith(color: AppColors.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
