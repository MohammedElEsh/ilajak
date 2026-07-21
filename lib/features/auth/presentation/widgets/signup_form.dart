import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: nameController,
            hint: AppStrings.authSignupName.tr(),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: AppColors.error,
              size: 14.r,
            ),
            validator: AppValidators.validateName,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: emailController,
            hint: AppStrings.authLoginEmailHint.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedMail01,
              color: AppColors.error,
              size: 14.r,
            ),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: passwordController,
            hint: AppStrings.authLoginPasswordHint.tr(),
            isPassword: true,
            textInputAction: TextInputAction.next,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedLockPassword,
              color: AppColors.error,
              size: 14.r,
            ),
            validator: AppValidators.validatePassword,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: confirmPasswordController,
            hint: AppStrings.authSignupConfirmPassword.tr(),
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedLockPassword,
              color: AppColors.error,
              size: 14.r,
            ),
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              passwordController.text,
            ),
          ),
        ],
      ),
    );
  }
}
