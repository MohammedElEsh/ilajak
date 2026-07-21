import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../manager/auth_register_cubit.dart';
import '../manager/auth_register_state.dart';
import '../widgets/signup_footer.dart';
import '../widgets/signup_form.dart';
import '../widgets/terms_agreement.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthRegisterCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _onSignIn() => context.push(RouteNames.login);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<AuthRegisterCubit, AuthRegisterState>(
          builder: (context, state) {
            final isLoading = state is AuthRegisterLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32.h),
                  Text(
                    AppStrings.authSignupTitle.tr(),
                    style: theme.textTheme.displayLarge,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.authSignupSubtitle.tr(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                      wordSpacing: 2.sp,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  SignupForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  SizedBox(height: 24.h),
                  TermsAgreement(onRegisterTap: () {}),
                  SizedBox(height: 24.h),
                  AppButton(
                    variant: AppButtonVariant.elevated,
                    label: AppStrings.authSignupButton.tr(),
                    onPressed: _onSignUp,
                    isLoading: isLoading,
                  ),

                  SizedBox(height: 24.h),
                  SignupFooter(onSignIn: _onSignIn),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
