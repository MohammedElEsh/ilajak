import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/profile/presentation/widgets/profile_hint_message.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.changePassword.tr(),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.forgetPasswordHint.tr(),
                    style: AppTypography.regular16.copyWith(
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.currentPassword.tr(),
                    style: AppTypography.semiBold14.copyWith(
                      color: AppColors.labelColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  isPassword: true,
                  hint: AppStrings.currentPassword.tr(),
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.newPassword.tr(),
                    style: AppTypography.semiBold14.copyWith(
                      color: AppColors.labelColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppTextField(isPassword: true, hint: AppStrings.newPassword.tr()),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.confirmNewPassword.tr(),
                    style: AppTypography.semiBold14.copyWith(
                      color: AppColors.labelColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  isPassword: true,
                  hint: AppStrings.confirmNewPassword.tr(),
                ),
                SizedBox(height: 36.h),
                Align(
                  alignment: Alignment.center,
                  child: ProfileHintMessage(
                    iconData: Icons.info_outline,
                    message: AppStrings.passwordHint.tr(),
                    textColor: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 40.h),
                AppButton(
                  label: AppStrings.saveChanges.tr(),
                  onPressed: () {},
                  variant: AppButtonVariant.elevated,
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.forgotPassword.tr(),
                    style: AppTypography.regular16.copyWith(
                      color: AppColors.primary,
                    ),
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
