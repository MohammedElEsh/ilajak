import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/profile/presentation/widgets/add_medication_buttom_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/current_medications_tile_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/health_info_card.dart';
import 'package:ilajak/features/profile/presentation/widgets/health_info_container_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/health_information_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/user_health_info_tile.dart';

class HealthInfoView extends StatelessWidget {
  const HealthInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.healthInfo.tr(),
        centerTitle: true,
        leadingWidget: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        actionWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: UnconstrainedBox(child: UserHealthInfoTile()),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: HealthInformationWidget(
                        icon: Icons.bloodtype_outlined,
                        iconColor: AppColors.error,
                        iconBgColor: AppColors.error.withValues(alpha: 0.1),
                        title: AppStrings.bloodType.tr(),
                        value: Text(
                          "O +",
                          style: AppTypography.bold28.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: HealthInformationWidget(
                        icon: Icons.shield_outlined,
                        iconColor: AppColors.primary,
                        iconBgColor: const Color.fromRGBO(210, 224, 248, 1),
                        title: AppStrings.status.tr(),
                        value: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "Verified",
                            style: AppTypography.medium12.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                HealthInfoCard(
                  childWidget: Column(
                    children: [
                      Row(
                        children: [
                          HealthInfoContainerWidget(
                            backgroundColor: AppColors.lightMint,
                            childWidget: Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.darkMint,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppStrings.allergies.tr(),
                            style: AppTypography.semiBold18.copyWith(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          HealthInfoContainerWidget(
                            backgroundColor: AppColors.lightRed,
                            childWidget: Row(
                              children: [
                                // icon penicilin with white color
                                Icon(
                                  Icons.emergency,
                                  color: AppColors.error,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  AppStrings.penicillin.tr(),
                                  style: AppTypography.medium16.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          HealthInfoContainerWidget(
                            childWidget: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppColors.lightGray,
                              ),
                              child: Text(
                                AppStrings.dust.tr(),
                                style: AppTypography.medium16.copyWith(
                                  color: AppColors.textPrimaryLight,
                                ),
                              ),
                            ),
                            backgroundColor: AppColors.lightGray,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                HealthInfoCard(
                  childWidget: Column(
                    children: [
                      Row(
                        children: [
                          HealthInfoContainerWidget(
                            backgroundColor: AppColors.secondary,
                            childWidget: Icon(
                              Icons.monitor_heart_outlined,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppStrings.chronicConditions.tr(),
                            style: AppTypography.semiBold18.copyWith(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hypertension",
                                  style: AppTypography.semiBold16.copyWith(
                                    color: AppColors.textPrimaryLight,
                                  ),
                                ),
                                Icon(
                                  Icons.info_outlined,
                                  color: AppColors.primary,
                                  size: 24.sp,
                                ),
                              ],
                            ),
                            Text(
                              "Diagnosed in April 2022",
                              style: AppTypography.regular16.copyWith(
                                color: AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                HealthInfoCard(
                  childWidget: Column(
                    children: [
                      Row(
                        children: [
                          HealthInfoContainerWidget(
                            backgroundColor: AppColors.secondary,
                            childWidget: Icon(
                              Icons.medical_services_outlined,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppStrings.currentMedications.tr(),
                            style: AppTypography.semiBold18.copyWith(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Material(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16.r),
                        child: CurrentMedicationsTile(
                          name: "Lisinopril",
                          dose: "10mg • Once daily",
                          onTap: () {},
                        ),
                      ),
                      SizedBox(height: 12.h),
                      AddMedicationButtomWidget(onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
