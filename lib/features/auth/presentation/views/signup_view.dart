import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../manager/auth_register_cubit.dart';
import '../manager/auth_register_state.dart';
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
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _genderValue;
  String? _bloodTypeValue;
  bool _agreeToTerms = false;

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthRegisterCubit>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        nationalId: _nationalIdController.text.trim(),
        dateOfBirth: _dateOfBirthController.text.trim(),
        gender: _genderValue ?? '',
        bloodType: _bloodTypeValue ?? '',
        address: _addressController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _onSignIn() => context.push(RouteNames.login);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();
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
                    phoneController: _phoneController,
                    nationalIdController: _nationalIdController,
                    dateOfBirthController: _dateOfBirthController,
                    genderValue: _genderValue,
                    onGenderChanged: (value) =>
                        setState(() => _genderValue = value),
                    bloodTypeValue: _bloodTypeValue,
                    onBloodTypeChanged: (value) =>
                        setState(() => _bloodTypeValue = value),
                    addressController: _addressController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  SizedBox(height: 24.h),
                  TermsAgreement(
                    isChecked: _agreeToTerms,
                    onChanged: (value) =>
                        setState(() => _agreeToTerms = value ?? false),
                    onTermsTap: () {},
                    onPrivacyTap: () {},
                  ),
                  SizedBox(height: 24.h),
                  AppButton(
                    variant: AppButtonVariant.elevated,
                    label: AppStrings.authSignupButton.tr(),
                    onPressed: _onSignUp,
                    isLoading: isLoading,
                    suffixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedUserCheck01,
                      color: colors.onPrimary,
                      size: 20.w,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.authSignupAlreadyHaveAccount.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      AppButton(
                        variant: AppButtonVariant.text,
                        label: AppStrings.authSignupSignIn.tr(),
                        onPressed: _onSignIn,
                        expanded: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
