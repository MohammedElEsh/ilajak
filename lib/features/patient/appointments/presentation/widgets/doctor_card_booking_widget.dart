import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/elevated_button_booking_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/info_box_widget.dart';

class DoctorCardWidget extends StatelessWidget {
  const DoctorCardWidget({
    super.key,
  this.doctorName,
   this.specialization,
   this.rating,
   this.reviews,
   this.experience,
   this.patients,
   this.availability,
   this.image,
   this.onTap,
  });
  final String? doctorName;
  final String? specialization;
  final String? rating;
  final String? reviews;
  final String? experience;
  final String? patients;
  final String? availability;
  final String? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage:  AssetImage(image??AppAssets.profileImage),
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
                    SizedBox(height: 12.h),
                    Text(
                      specialization ?? "Neurologist",
                      style: AppTypography.medium16.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4.w),
                      Text(rating??"5.0", style: AppTypography.semiBold18),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    reviews??"98 Reviews",
                    style: AppTypography.medium16.copyWith(
                      color: AppColors.fieldLabel,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: InfoBoxWidget(title: "Experience", value: experience??"12 Years"),
              ),
              SizedBox(width: 16.w),
               Expanded(
                child: InfoBoxWidget(title: "Patients", value:patients?? "2.4k+"),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: InfoBoxWidget(title: "Availability", value: availability?? "Tomorrow"),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          ElevatedButtonBookingWidget(text: 'Book Appointment ', onTap: () {}),
        ],
      ),
    );
  }
}
