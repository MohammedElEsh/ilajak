import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

/// A single row in the "Upcoming Today" list on Doctor Home.
///
/// Set [isLive] to render the highlighted "in progress" state (accent
/// border, LIVE badge, and a "Start Visit" button instead of a chevron).
class DoctorAppointmentCard extends StatelessWidget {
  const DoctorAppointmentCard({
    super.key,
    required this.patientName,
    required this.timeLabel,
    this.room,
    this.isLive = false,
    this.onTap,
    this.onStartVisit,
  });

  /// e.g. "Robert Wilson"
  final String patientName;

  /// e.g. "10:30 AM • Follow-up"
  final String timeLabel;

  /// e.g. "ROOM 402". Pass null to hide the room badge.
  final String? room;

  final bool isLive;
  final VoidCallback? onTap;
  final VoidCallback? onStartVisit;

  @override
  Widget build(BuildContext context) {
    final accentColor = isLive ? AppColors.primary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: isLive ? AppColors.primaryLight2 : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(18.r),
          border: isLive ? Border.all(color: AppColors.primary, width: 1.5) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(Icons.person_outline, color: AppColors.primary, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          patientName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.semiBold16.copyWith(
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                      ),
                      if (isLive) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            AppStrings.doctorHomeLiveBadge.tr(),
                            style: AppTypography.regular12.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14.sp, color: accentColor),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          timeLabel,
                          overflow: TextOverflow.ellipsis,
                          style: isLive
                              ? AppTypography.semiBold14.copyWith(color: AppColors.primary)
                              : AppTypography.regular14.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (room != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      room!,
                      style: AppTypography.regular12.copyWith(color: AppColors.surfaceLight),
                    ),
                  ),
                SizedBox(height: 8.h),
                if (isLive)
                  SizedBox(
                    height: 34.h,
                    child: ElevatedButton(
                      onPressed: onStartVisit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.doctorHomeStartVisit.tr(),
                        style: AppTypography.semiBold14.copyWith(
                          color: AppColors.surfaceLight,
                        ),
                      ),
                    ),
                  )
                else
                  const Icon(Icons.chevron_right, color: AppColors.listTileArrowIcon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
