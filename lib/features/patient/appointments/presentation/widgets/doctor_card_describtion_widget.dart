import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';

class DoctorCardDescribtionWidget extends StatelessWidget {
  const DoctorCardDescribtionWidget({
    super.key,
    required this.doctor,
    this.image,
  });
  final DoctorModel doctor;

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              image ?? AppAssets.profileImage,
              width: 80.w,
              height: 94.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: AppTypography.semiBold18,
                ),
                SizedBox(height: 8.h),
                Text(
                  doctor.specialization,
                  style: AppTypography.medium16.copyWith(
                    color: AppColors.labelColor,
                  ),
                ),
                SizedBox(height: 4.h),

                Text(
                  "${doctor.experience.toString()} Years Experience",
                  style: AppTypography.medium16.copyWith(
                    color: AppColors.labelColor,
                  ),
                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4.w),
                    Text(
                      doctor.averageRating.toString(),
                      style: AppTypography.semiBold18,
                    ),
                    Text(
                      " (${doctor.reviews.toString()})",
                      style: AppTypography.medium16.copyWith(
                        color: AppColors.labelColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
