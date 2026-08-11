import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single patient row on the Doctor "Patients" list screen.
///
/// [isActive] drives the status pill (Active vs Pending) and
/// [isNextAppointmentScheduled] switches the "Next Appointment" value
/// between its normal blue styling and the muted "Not Scheduled" look.
class PatientListCard extends StatelessWidget {
  const PatientListCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.statusLabel,
    required this.lastVisitLabel,
    required this.lastVisit,
    required this.nextAppointmentLabel,
    required this.nextAppointment,
    this.imageUrl,
    this.isActive = true,
    this.isNextAppointmentScheduled = true,
    this.onTap,
  });

  final String name;

  /// e.g. "28, Female"
  final String subtitle;

  /// e.g. "Active" / "Pending"
  final String statusLabel;

  /// Localized eyebrow caption, e.g. "LAST VISIT"
  final String lastVisitLabel;

  /// e.g. "Oct 12, 2023"
  final String lastVisit;

  /// Localized eyebrow caption, e.g. "NEXT APPOINTMENT"
  final String nextAppointmentLabel;

  /// e.g. "Tomorrow, 10:30 AM" or the "Not Scheduled" copy
  final String nextAppointment;

  final String? imageUrl;
  final bool isActive;
  final bool isNextAppointmentScheduled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusBg = isActive ? AppColors.secondary : AppColors.textSecondary.withValues(alpha: .12);
    final statusFg = isActive ? AppColors.primary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: imageUrl != null
                      ? Image.network(imageUrl!, width: 56.w, height: 56.h, fit: BoxFit.cover)
                      : Container(
                          width: 56.w,
                          height: 56.h,
                          color: AppColors.secondary,
                          child: Icon(Icons.person_outline, color: AppColors.primary, size: 28.sp),
                        ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.semiBold18.copyWith(color: AppColors.textPrimaryLight),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: AppTypography.regular14.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusLabel,
                    style: AppTypography.semiBold14.copyWith(color: statusFg),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            const Divider(height: 1, color: AppColors.divider),
            SizedBox(height: 14.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InfoColumn(
                    eyebrow: lastVisitLabel,
                    value: lastVisit,
                    valueColor: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _InfoColumn(
                    eyebrow: nextAppointmentLabel,
                    value: nextAppointment,
                    valueColor: isNextAppointmentScheduled
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.eyebrow, required this.value, required this.valueColor});

  final String eyebrow;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: AppTypography.medium12.copyWith(color: AppColors.textSecondary, letterSpacing: .5),
        ),
        SizedBox(height: 4.h),
        Text(value, style: AppTypography.semiBold14.copyWith(color: valueColor)),
      ],
    );
  }
}
