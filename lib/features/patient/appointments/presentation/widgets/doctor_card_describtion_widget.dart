import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class DoctorCardDescribtionWidget extends StatelessWidget {
  const DoctorCardDescribtionWidget({
    super.key,
    this.doctorName,
    this.specialization,
    this.rating,
    this.reviews,
    this.experience,
    this.image,
  });
  final String? doctorName;
  final String? specialization;
  final String? rating;
  final String? reviews;
  final String? experience;
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
                  doctorName ?? 'Dr. Elena Rodriguez',
                  style: AppTypography.semiBold18,
                ),
                SizedBox(height: 8.h),
                Text(
                  specialization ?? "Neurologist",
                  style: AppTypography.medium16.copyWith(
                    color: AppColors.labelColor,
                  ),
                ),
                SizedBox(height: 4.h),

                Text(
                  experience ?? "12 Years Expreience",
                  style: AppTypography.medium16.copyWith(
                    color: AppColors.labelColor,
                  ),
                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4.w),
                    Text(rating ?? "5.0", style: AppTypography.semiBold18),
                    Text(
                      " (${reviews ?? "98 Reviews"})",
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
