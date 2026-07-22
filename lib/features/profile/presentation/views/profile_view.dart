import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/profile/presentation/widgets/profile_image_avatar.dart';
import 'package:ilajak/features/profile/presentation/widgets/profile_information_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/settings_card_widget.dart';
import 'package:ilajak/features/profile/presentation/widgets/settings_tile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
            strokeWidth: 1.5,
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                // Profile image
                const ProfileImageAvatar(),
                SizedBox(height: 16.h),
                Text('Mohamed Ehab', style: AppTypography.semiBold22),
                SizedBox(height: 4.h),
                Text('Member since Oct 2023', style: AppTypography.medium12),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    const Expanded(
                      child: ProfileInformationWidget(
                        label: AppStrings.profileAppointments,
                        count: 12,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: ProfileInformationWidget(
                        label: AppStrings.profileRecords,
                        count: 8,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: ProfileInformationWidget(
                        label: AppStrings.profileArticles,
                        count: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.profileSettings.tr(),
                    style: AppTypography.semiBold22,
                  ),
                ),
                SizedBox(height: 16.h),
                Column(
                  children: [
                    SettingsCard(
                      children: [
                        // Personal info tile
                        SettingsTile(
                          icon: Icons.person_outline,
                          title: AppStrings.personalInfoTitle.tr(),
                          showDivider: true,
                          onTap: () {
                            context.push(RouteNames.personalInfo);
                          },
                        ),
                        // Health info tile
                        SettingsTile(
                          icon: Icons.medical_services_outlined,
                          title: AppStrings.healthInfo.tr(),
                          showDivider: true,
                          onTap: () {
                            context.push(RouteNames.healthInfo);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SettingsCard(
                      children: [
                        SettingsTile(
                          icon: Icons.lock_outline,
                          title: AppStrings.password.tr(),
                          showDivider: false,
                          onTap: () {
                            context.push(RouteNames.changePassword);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    const Divider(
                      color: AppColors.divider,
                      thickness: 1.5,
                      indent: 56,
                      endIndent: 56,
                    ),
                    SizedBox(height: 18.h),
                    SettingsCard(
                      children: [
                        // Logout tile
                        SettingsTile(
                          icon: Icons.logout,
                          title: AppStrings.logout.tr(),
                          iconBackgroundColor:
                              AppColors.redTileIconBackgroundColor,
                          iconColor: AppColors.error,
                          textColor: AppColors.error,
                          onTap: () {
                            // Show logout dialod
                            showLogOutDialog(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 120.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Logout Icon
            CircleAvatar(
              radius: 64.r,
              backgroundColor: AppColors.secondary,
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.logout,
                  color: AppColors.surfaceLight,
                  size: 32.sp,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            /// Title
            Text(
              AppStrings.logoutQuestion.tr(),
              textAlign: TextAlign.center,
              style: AppTypography.semiBold22,
            ),

            SizedBox(height: 12.h),

            /// Description
            Text(
              AppStrings.logoutHint.tr(),
              textAlign: TextAlign.center,
              style: AppTypography.regular16.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: 32.h),

            /// Stay Logged In
            AppButton(
              label: AppStrings.stayLoggedIn.tr(),
              onPressed: () {
                Navigator.pop(context);
              },
              variant: AppButtonVariant.elevated,
            ),

            SizedBox(height: 16.h),

            /// Logout
            AppButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error, width: 1.5),
                foregroundColor: AppColors.error,
              ),
              label: AppStrings.logout.tr(),
              onPressed: () {},
              variant: AppButtonVariant.outlined,
            ),
          ],
        ),
      );
    },
  );
}
