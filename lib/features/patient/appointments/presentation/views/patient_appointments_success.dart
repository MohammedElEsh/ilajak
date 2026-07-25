import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/appointmentdeatailscard_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/elevated_button_booking_widget.dart';

class PatientAppointmentsSuccessView extends StatelessWidget {
  const PatientAppointmentsSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.homeAppBarTitle.tr(),
        leadingWidget: Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedCheckmarkCircle02,
              size: 30.sp,
              color: AppColors.surfaceLight,
              strokeWidth: 1.5,
            ),
          ),
        ),
        actionWidget: Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedXVariableCircle,
              size: 30.sp,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              Center(
                child: CircleAvatar(
                  radius: 110.r,
                  backgroundImage: const AssetImage(
                    AppAssets.appointmentSuccess,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                "Appointment Confirmed!",
                style: AppTypography.bold28.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  "Your visit has been successfully scheduled.\nWe’ve sent a confirmation to your email.",
                  style: AppTypography.regular16.copyWith(
                    color: AppColors.darkMint,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const AppointmentDetailsCard(
                doctorName: "Dr. Sarah Johnson",
                specialization: "Cardiology",
                date: "Today, 2:30 PM",
                time: "02:30 PM",
                address: "123 Health St., Heartville, CA 90210",
                doctorImage: AppAssets.profileImage,
                mapImage: AppAssets.mapImage,
                status: "Confirmed",
              ),
              const SizedBox(height: 32),
              ElevatedButtonBookingWidget(
                text: "View My Appointments",
                onTap: () {},
                color1: Colors.white,
                color2: AppColors.primary,
                prefiXIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedEye,
                  size: 24.0,
                  color: AppColors.primary,
                  strokeWidth: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft02,
                      size: 24.0,
                      color: AppColors.darkMint,
                      strokeWidth: 1.5,
                    ),

                    TextButton(
                      onPressed: () {
                        context.go(RouteNames.patientHome);
                      },
                      child: Text(
                        "Back to Home",
                        style: AppTypography.semiBold16.copyWith(
                          color: AppColors.darkMint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
