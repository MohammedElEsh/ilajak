import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/date_time_widget.dart';

class MyAppointmentCard extends StatelessWidget {
  final VoidCallback onReschedule;
  final VoidCallback onCancel;
  final String? doctorImageUrl;
  final String? doctorName;
  final String? doctorSpecialty;
  final String? time;
  final String? date;
  final String? location;
  const MyAppointmentCard({
    super.key,
    required this.onReschedule,
    required this.onCancel,
    this.doctorName,
    this.doctorSpecialty,
    this.time,
    this.date,
    this.location,
    this.doctorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  doctorImageUrl ?? AppAssets.profileImage,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName ?? 'Dr. Sarah Johnson',
                      style: AppTypography.semiBold20.copyWith(
                        color: AppColors.backgroundDark,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    Text(
                      doctorSpecialty ?? 'Cardiologist',
                      style: AppTypography.regular14.copyWith(
                        color: AppColors.primaryLight3,
                      ),
                    ),
                  ],
                ),
              ),
              StatusWidget(title: AppStrings.upcoming.tr()),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              DateTimeWidget(
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCalendar02,
                  size: 22,
                  color: AppColors.primary,
                  strokeWidth: 1.5,
                ),
                title1: AppStrings.date.tr(),
                title2: date ?? 'Oct 24, 2023',
              ),
              DateTimeWidget(
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedTime02,
                  size: 22,
                  color: AppColors.primary,
                  strokeWidth: 1.5,
                ),
                title1: AppStrings.time.tr(),
                title2: time ?? '10:30 AM',
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedLocation01,
                size: 24.0,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location ?? 'HeartCare Institute, Floor 4',
                  style: AppTypography.regular14.copyWith(
                    color: AppColors.darkMint,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onReschedule,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    AppStrings.reschedule.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0284C7),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF02569B),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppStrings.cancel.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
