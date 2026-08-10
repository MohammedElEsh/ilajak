import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/info_box_widget.dart';

class AppointmentDetailsCard extends StatelessWidget {
  const AppointmentDetailsCard({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.clinicName,
    required this.address,
    required this.doctorImage,
    required this.mapImage,
  });

  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String clinicName;
  final String address;
  final String doctorImage;
  final String mapImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  doctorImage,
                  width: 58.w,
                  height: 58.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.doctor.tr(),
                      style: AppTypography.regular15.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(doctorName, style: AppTypography.semiBold18),
                    SizedBox(height: 4.h),

                    Text(
                      specialization,
                      style: AppTypography.regular16.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              StatusWidget(
                title: AppStrings.confirmed.tr(),
                backgroundColor: AppColors.lightMint,
                textColor: AppColors.primary,
              ),
            ],
          ),

          SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                child: InfoBoxWidget(title: AppStrings.date.tr(), value: date),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: InfoBoxWidget(title: AppStrings.time.tr(), value: time),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedLocation01,
                color: AppColors.primary,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                AppStrings.clinicAddress.tr(),
                style: AppTypography.medium14.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Text(
                clinicName,
                style: AppTypography.semiBold16.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                address,
                style: AppTypography.semiBold16.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              mapImage,
              width: double.infinity,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
