import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/widgets/status_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HealthView extends StatelessWidget {
  const HealthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
          actionWidget: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                size: 24.sp,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
              SizedBox(width: 8.w),
              HugeIcon(
                icon: HugeIcons.strokeRoundedFilterMail,
                size: 24.sp,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  height: 176.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight3,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lab Results",
                        style: AppTypography.bold28.copyWith(
                          color: AppColors.surfaceLight,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Monitor your progress with\nclinical precision.",
                        style: AppTypography.regular14.copyWith(
                          color: AppColors.surfaceLight,
                          height: 1.5,
                          wordSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  color: AppColors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      // Headre Column
                      Column(
                        children: [
                          // Row of title and statu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedLabs,
                                    size: 24.sp,
                                    color: AppColors.primary,
                                    strokeWidth: 1.5,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Lipid Profile",
                                    style: AppTypography.semiBold18.copyWith(
                                      color: AppColors.textPrimaryLight,
                                    ),
                                  ),
                                ],
                              ),
                              StatusWidget(
                                title: "High",
                                backgroundColor:
                                    AppColors.redTileIconBackgroundColor,
                                textColor: AppColors.error,
                                textStyle: AppTypography.bold12,
                              ),
                            ],
                          ),
                          // Text
                        ],
                      ),

                      // Statistics card row

                      // View details and download button
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
