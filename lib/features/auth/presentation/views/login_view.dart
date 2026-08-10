import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../manager/auth_login_cubit.dart';
import '../manager/auth_login_state.dart';
import '../widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthLoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _onCreateAccount() => context.push(RouteNames.roleSelection);

  void _onForgotPassword() => context.push(RouteNames.forgotPassword);

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = 'mohamed@gmail.com';
      _passwordController.text = 'M12345678';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocListener<AuthLoginCubit, AuthLoginState>(
          listener: (context, state) {
            if (state is AuthLoginError) {
              FeedbackHandler.error(state.message);
            }
          },
          child: BlocBuilder<AuthLoginCubit, AuthLoginState>(
            builder: (context, state) {
              final isLoading = state is AuthLoginLoading;

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
                              padding: EdgeInsets.all(8.w),
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedFirstAidKit,
                                color: colors.onPrimary,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Center(
                            child: Text(
                              AppConstants.appName,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                color: colors.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            AppStrings.authLoginWelcomeBack.tr(),
                            style: theme.textTheme.displayLarge,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppStrings.authLoginDescription.tr(),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colors.onSurfaceVariant,
                              wordSpacing: 2.sp,
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 36.h),
                          LoginForm(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            rememberMe: _rememberMe,
                            onRememberMeChanged: (v) =>
                                setState(() => _rememberMe = v),
                            onForgotPassword: _onForgotPassword,
                          ),
                          SizedBox(height: 18.h),
                          AppButton(
                            variant: AppButtonVariant.elevated,
                            label: AppStrings.authLoginButton.tr(),
                            onPressed: _onLogin,
                            isLoading: isLoading,
                            suffixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                              color: colors.onPrimary,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  AppStrings.authOrContinueWith.tr(),
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          AppButton(
                            variant: AppButtonVariant.outlined,
                            label: AppStrings.authSignupButton.tr(),
                            onPressed: _onCreateAccount,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
