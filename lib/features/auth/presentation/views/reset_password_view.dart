import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../manager/auth_reset_password_cubit.dart';
import '../manager/auth_reset_password_state.dart';
import '../widgets/reset_password_form.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthResetPasswordCubit>().resetPassword(
          email: widget.email,
          otp: widget.otp,
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocConsumer<AuthResetPasswordCubit, AuthResetPasswordState>(
          listener: (context, state) {
            if (state is AuthResetPasswordSuccess) {
              FeedbackHandler.success(AppStrings.authResetPasswordSuccess.tr());
              context.go(RouteNames.login);
            } else if (state is AuthResetPasswordError) {
              FeedbackHandler.error(state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthResetPasswordLoading;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 32.h),
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
                                icon: HugeIcons.strokeRoundedPasswordValidation,
                                color: colors.primary,
                                size: 84.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          AppStrings.authResetPasswordTitle.tr(),
                          style: theme.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          AppStrings.authResetPasswordSubtitle.tr(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colors.onSurfaceVariant,
                            wordSpacing: 2.sp,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 48.h),
                        ResetPasswordForm(
                          formKey: _formKey,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                        ),
                        SizedBox(height: 36.h),
                        AppButton(
                          variant: AppButtonVariant.elevated,
                          label: AppStrings.authResetPasswordButton.tr(),
                          onPressed: _onSubmit,
                          isLoading: isLoading,
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
