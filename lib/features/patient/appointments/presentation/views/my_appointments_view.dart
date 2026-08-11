import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/custom_tap_bar_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/my_appointment_card_widget.dart';

class MyAppointmentsView extends StatelessWidget {
  const MyAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        leadingWidget: Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
        ),
        actionWidget: Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
            strokeWidth: 1.5,
          ),
        ),
        titleWidget: Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                AppStrings.myAppointments.tr(),
                style: AppTypography.bold28.copyWith(
                  color: AppColors.backgroundDark,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.center,
                AppStrings.manageAppointments.tr(),
                style: AppTypography.regular16.copyWith(
                  color: AppColors.darkMint,
                ),
              ),
              SizedBox(height: 24.h),
              const CustomTabBar(),
              SizedBox(height: 24.h),
              ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return MyAppointmentCard(
                    onCancel: () {},
                    onReschedule: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
