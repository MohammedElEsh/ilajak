import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.authLoginEmail.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            controller: emailController,
            hint: AppStrings.authLoginEmailHint.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedMail01,
              color: AppColors.fieldLabel,
              size: 24.r,
            ),
            validator: AppValidators.validateEmail,
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.authLoginPassword.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            controller: passwordController,
            hint: '••••••••••••',
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSquareLock01,
              color: AppColors.fieldLabel,
              size: 24.r,
            ),
            validator: (v) => AppValidators.validatePassword(v),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24.w,
                    width: 24.w,
                    child: Checkbox(
                      value: rememberMe,
                      onChanged: (v) => onRememberMeChanged(v ?? false),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    AppStrings.authLoginRememberMe.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              AppButton(
                variant: AppButtonVariant.text,
                label: AppStrings.authLoginForgotPassword.tr(),
                onPressed: onForgotPassword,
                expanded: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
