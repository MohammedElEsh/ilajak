import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../widgets/forgot_password_form.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement forgot password logic
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 32.h),
              Text(
                AppStrings.authForgotPasswordTitle.tr(),
                textAlign: TextAlign.left,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(height: 32.h),
              ForgotPasswordForm(
                formKey: _formKey,
                emailController: _emailController,
              ),
              SizedBox(height: 64.h),
              AppButton(
                variant: AppButtonVariant.elevated,
                label: AppStrings.authForgotPasswordSubmit.tr(),
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
