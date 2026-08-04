import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/profile/presentation/widgets/profile_info_card.dart';
import 'package:ilajak/features/doctor/profile/presentation/widgets/profile_settings_tile.dart';

// TODO(backend): hardcoded (Dr. Sarah Al-Fayed, from the mock) — swap for
// the real doctor-profile cubit once the API/integration work starts.
class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          // NOTE: the mock shows a hamburger icon here (unlike every other
          // doctor screen, which uses the circular logo avatar) — there's
          // no drawer content designed anywhere yet, so this is wired as a
          // TODO no-op rather than a real Scaffold.drawer. Flagged in chat.
          leadingWidget: GestureDetector(
            onTap: () {
              // TODO(design): open a Drawer here once its contents are designed.
            },
            child: Icon(Icons.menu, color: context.appColors.primary, size: 24.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorHomeAppBarTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: context.appColors.primary,
            strokeWidth: 1.5,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 110.w,
                          height: 110.h,
                          color: context.appColors.secondary,
                          child: Icon(Icons.person_outline, color: context.appColors.primary, size: 48.sp),
                        ),
                      ),
                      Positioned(
                        bottom: -2.h,
                        right: -2.w,
                        child: Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: context.appColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: context.appColors.background, width: 2),
                          ),
                          child: Icon(Icons.edit, color: context.appColors.surface, size: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    'Dr. Sarah Al-Fayed',
                    style: AppTypography.semiBold22.copyWith(color: context.appColors.textPrimary),
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: Text(
                    'Cardiologist',
                    style: AppTypography.semiBold16.copyWith(color: context.appColors.primary),
                  ),
                ),
                SizedBox(height: 22.h),

                _SectionLabel(AppStrings.doctorProfileProfessionalDetails.tr()),
                SizedBox(height: 10.h),
                ProfileInfoCard(
                  icon: Icon(Icons.apartment_outlined, color: context.appColors.primary, size: 20.sp),
                  label: AppStrings.doctorProfileClinic.tr(),
                  value: 'City Wellness Center',
                ),
                SizedBox(height: 12.h),
                ProfileInfoCard(
                  icon: Icon(Icons.monitor_heart_outlined, color: context.appColors.primary, size: 20.sp),
                  label: AppStrings.doctorProfileSpecialization.tr(),
                  value: 'Cardiologist',
                ),
                SizedBox(height: 22.h),

                _SectionLabel(AppStrings.doctorProfileContactInformation.tr()),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProfileInfoCard(
                        icon: Icon(Icons.call_outlined, color: context.appColors.primary, size: 20.sp),
                        label: AppStrings.doctorProfilePhone.tr(),
                        value: '+966 50 123 4567',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ProfileInfoCard(
                        icon: Icon(Icons.mail_outline, color: context.appColors.primary, size: 20.sp),
                        label: AppStrings.doctorProfileEmail.tr(),
                        value: 'sara@gmail.com',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),

                _SectionLabel(AppStrings.doctorProfileLegalInfo.tr()),
                SizedBox(height: 10.h),
                ProfileInfoCard(
                  icon: Icon(Icons.verified_user_outlined, color: context.appColors.primary, size: 20.sp),
                  label: AppStrings.doctorProfileLicenseNumber.tr(),
                  value: 'MED-88293-CF',
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: context.appColors.success.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      AppStrings.doctorProfileStatusActive.tr(),
                      style: AppTypography.semiBold14.copyWith(color: context.appColors.success),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),

                _SectionLabel(AppStrings.doctorProfileAppSettings.tr()),
                SizedBox(height: 10.h),
                ProfileSettingsTile(
                  icon: Icons.notifications_outlined,
                  label: AppStrings.doctorProfileNotifications.tr(),
                  onTap: () {
                    // TODO(design): no Notification-settings screen designed
                    // yet — wire once it exists.
                  },
                ),
                SizedBox(height: 12.h),
                ProfileSettingsTile(
                  icon: Icons.shield_outlined,
                  label: AppStrings.doctorProfilePassword.tr(),
                  onTap: () => context.push(RouteNames.doctorChangePasswordFullPath),
                ),
                SizedBox(height: 22.h),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO(backend): wire real sign-out via SessionManager.
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.appColors.error),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: context.appColors.error, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          AppStrings.doctorProfileLogOut.tr(),
                          style: AppTypography.semiBold16.copyWith(color: context.appColors.error),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h + context.bottomNavClearance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.medium12.copyWith(color: context.appColors.textSecondary, letterSpacing: .5),
    );
  }
}
