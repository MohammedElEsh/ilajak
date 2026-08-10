import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.authResetPasswordLabel.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            controller: widget.passwordController,
            hint: AppStrings.authResetPasswordHint.tr(),
            isPassword: true,
            enablePasswordToggle: true,
            textInputAction: TextInputAction.next,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSquareLock01,
              color: AppColors.fieldLabel,
              size: 24.r,
            ),
            validator: (value) => AppValidators.validatePassword(value),
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.authResetPasswordConfirmLabel.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            controller: widget.confirmPasswordController,
            hint: AppStrings.authResetPasswordConfirmHint.tr(),
            isPassword: true,
            enablePasswordToggle: true,
            textInputAction: TextInputAction.done,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSquareLock01,
              color: AppColors.fieldLabel,
              size: 24.r,
            ),
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              widget.passwordController.text,
            ),
          ),
        ],
      ),
    );
  }
}
