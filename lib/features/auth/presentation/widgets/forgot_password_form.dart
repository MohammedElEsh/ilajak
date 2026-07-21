import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

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
            AppStrings.authForgotPasswordEmailLabel.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            controller: emailController,
            hint: AppStrings.authLoginEmailHint.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedMail01,
              color: AppColors.fieldLabel,
              size: 24.r,
            ),
            validator: AppValidators.validateEmail,
          ),
        ],
      ),
    );
  }
}
