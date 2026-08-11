import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/feedback/app_error_widget.dart';
import 'package:ilajak/core/shared/images/app_cached_image.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/loading/app_loading.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/profile/presentation/manager/doctor_profile_cubit.dart';
import 'package:ilajak/features/doctor/profile/presentation/manager/doctor_profile_state.dart';
import 'package:ilajak/features/doctor/profile/presentation/widgets/profile_info_card.dart';
import 'package:ilajak/features/doctor/profile/presentation/widgets/profile_settings_tile.dart';

class DoctorProfileView extends StatefulWidget {
  const DoctorProfileView({super.key});

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorProfileCubit>().loadProfile();
  }

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
            child: Icon(Icons.menu, color: AppColors.primary, size: 24.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorHomeAppBarTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: AppColors.primary),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
            strokeWidth: 1.5,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
              if (state is DoctorProfileError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () => context.read<DoctorProfileCubit>().loadProfile(),
                );
              }

              if (state is! DoctorProfileLoaded) {
                return const AppLoading();
              }

              final profile = state.profile;
              final isUploadingAvatar = state.isUploadingAvatar;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: (profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty)
                                ? AppCachedImage(
                                    imageUrl: profile.avatarUrl!,
                                    width: 110.w,
                                    height: 110.h,
                                  )
                                : Container(
                                    width: 110.w,
                                    height: 110.h,
                                    color: AppColors.secondary,
                                    child: Icon(Icons.person_outline, color: AppColors.primary, size: 48.sp),
                                  ),
                          ),
                          Positioned(
                            bottom: -2.h,
                            right: -2.w,
                            child: GestureDetector(
                              onTap: isUploadingAvatar
                                  ? null
                                  : () => context.read<DoctorProfileCubit>().changeAvatar(),
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.backgroundLight, width: 2),
                                ),
                                child: isUploadingAvatar
                                    ? Padding(
                                        padding: EdgeInsets.all(6.r),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.surfaceLight,
                                        ),
                                      )
                                    : Icon(Icons.edit, color: AppColors.surfaceLight, size: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        profile.name ?? '—',
                        style: AppTypography.semiBold22.copyWith(color: AppColors.textPrimaryLight),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: Text(
                        profile.specialization ?? '—',
                        style: AppTypography.semiBold16.copyWith(color: AppColors.primary),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    _SectionLabel(AppStrings.doctorProfileProfessionalDetails.tr()),
                    SizedBox(height: 14.h),
                    ProfileInfoCard(
                      icon: Icon(Icons.apartment_outlined, color: AppColors.primary, size: 20.sp),
                      label: AppStrings.doctorProfileClinic.tr(),
                      value: profile.firstClinicName ?? '—',
                    ),
                    SizedBox(height: 12.h),
                    ProfileInfoCard(
                      icon: Icon(Icons.monitor_heart_outlined, color: AppColors.primary, size: 20.sp),
                      label: AppStrings.doctorProfileSpecialization.tr(),
                      value: profile.specialization ?? '—',
                    ),
                    SizedBox(height: 24.h),

                    _SectionLabel(AppStrings.doctorProfileContactInformation.tr()),
                    SizedBox(height: 14.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ProfileInfoCard(
                            icon: Icon(Icons.call_outlined, color: AppColors.primary, size: 20.sp),
                            label: AppStrings.doctorProfilePhone.tr(),
                            value: profile.phone ?? '—',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ProfileInfoCard(
                            icon: Icon(Icons.mail_outline, color: AppColors.primary, size: 20.sp),
                            label: AppStrings.doctorProfileEmail.tr(),
                            value: profile.email ?? '—',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    _SectionLabel(AppStrings.doctorProfileLegalInfo.tr()),
                    SizedBox(height: 14.h),
                    ProfileInfoCard(
                      icon: Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 20.sp),
                      label: AppStrings.doctorProfileLicenseNumber.tr(),
                      value: profile.licenseNumber ?? '—',
                      trailing: profile.status == 'active'
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: .12),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                AppStrings.doctorProfileStatusActive.tr(),
                                style: AppTypography.semiBold14.copyWith(color: AppColors.success),
                              ),
                            )
                          : null,
                    ),
                    SizedBox(height: 24.h),

                    _SectionLabel(AppStrings.doctorProfileAppSettings.tr()),
                    SizedBox(height: 14.h),
                    ProfileSettingsTile(
                      icon: Icons.notifications_outlined,
                      label: AppStrings.doctorProfileNotifications.tr(),
                      onTap: () {
                        // TODO(design): no Notification-settings screen designed
                        // yet — wire once it exists.
                      },
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(height: 22.h),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => context.read<DoctorProfileCubit>().logout(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.error),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: AppColors.error, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.doctorProfileLogOut.tr(),
                              style: AppTypography.semiBold16.copyWith(color: AppColors.error),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
                  ],
                ),
              );
            },
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
      style: AppTypography.medium12.copyWith(color: AppColors.textSecondary, letterSpacing: .5),
    );
  }
}
