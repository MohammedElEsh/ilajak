import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
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
      context.push(RouteNames.verifyOtp, extra: _emailController.text.trim());
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
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 64.h),
                  Center(
                    child: Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedLockSync01,
                          color: colors.primary,
                          size: 84.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    AppStrings.authForgotPasswordTitle.tr(),
                    style: theme.textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppStrings.authForgotPasswordSubtitle.tr(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                      wordSpacing: 2.sp,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 64.h),
                  ForgotPasswordForm(
                    formKey: _formKey,
                    emailController: _emailController,
                  ),
                  SizedBox(height: 36.h),
                  AppButton(
                    variant: AppButtonVariant.elevated,
                    label: AppStrings.authForgotPasswordSubmit.tr(),
                    onPressed: _onSubmit,
                    suffixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowRight02,
                      color: colors.onPrimary,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
