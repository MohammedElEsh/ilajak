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
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../manager/doctor_register_cubit.dart';
import '../manager/doctor_register_state.dart';
import '../widgets/terms_agreement.dart';

class DoctorSignupView extends StatefulWidget {
  const DoctorSignupView({super.key});

  @override
  State<DoctorSignupView> createState() => _DoctorSignupViewState();
}

class _DoctorSignupViewState extends State<DoctorSignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _medicalIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;

  String? _validateMedicalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.authDoctorSignupMedicalIdRequired.tr();
    }
    return null;
  }

  void _onCreateAccount() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // NOTE: unchecked terms doesn't block submission — mirrors
    // signup_view.dart's existing behavior (TermsAgreement there isn't
    // gated either). Flagged in chat if you'd rather enforce it here.
    context.read<DoctorRegisterCubit>().register(
          name: _nameController.text.trim(),
          medicalId: _medicalIdController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        );
  }

  void _onLogIn() => context.push(RouteNames.login);

  @override
  void dispose() {
    _nameController.dispose();
    _medicalIdController.dispose();
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
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocListener<DoctorRegisterCubit, DoctorRegisterState>(
          listener: (context, state) {
            if (state is DoctorRegisterError) {
              FeedbackHandler.error(state.message);
            }
            // On DoctorRegisterSuccess there's nothing to do here — the
            // repository already logs the doctor in (fresh token from the
            // register response), so the router's refreshListenable picks
            // up the session change and redirects into the doctor shell
            // on its own, same as after a normal login.
          },
          child: BlocBuilder<DoctorRegisterCubit, DoctorRegisterState>(
            builder: (context, state) {
              final isLoading = state is DoctorRegisterLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextButton(
                              onPressed: () => context.go(RouteNames.roleSelection),
                              child: Text(
                                AppStrings.authChangeRole.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedFirstAidKit,
                            color: colors.onPrimary,
                            size: 32.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        AppStrings.authDoctorSignupTitle.tr(),
                        style: theme.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppStrings.authDoctorSignupSubtitle.tr(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                          wordSpacing: 2.sp,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),

                      Text(
                        AppStrings.authDoctorSignupFullName.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _nameController,
                        hint: AppStrings.authDoctorSignupFullNameHint.tr(),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          color: AppColors.fieldLabel,
                          size: 24.r,
                        ),
                        validator: AppValidators.validateName,
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        AppStrings.authDoctorSignupMedicalId.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _medicalIdController,
                        hint: AppStrings.authDoctorSignupMedicalIdHint.tr(),
                        textInputAction: TextInputAction.next,
                        prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedId,
                          color: AppColors.fieldLabel,
                          size: 24.r,
                        ),
                        validator: _validateMedicalId,
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        AppStrings.authDoctorSignupWorkEmail.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _emailController,
                        hint: AppStrings.authDoctorSignupWorkEmailHint.tr(),
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
                        AppStrings.authDoctorSignupPassword.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _passwordController,
                        hint: AppStrings.authDoctorSignupPasswordHint.tr(),
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedSquareLock01,
                          color: AppColors.fieldLabel,
                          size: 24.r,
                        ),
                        validator: (v) => AppValidators.validatePassword(v),
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        AppStrings.authDoctorSignupConfirmPassword.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _confirmPasswordController,
                        hint: AppStrings.authDoctorSignupConfirmPasswordHint.tr(),
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedPasswordValidation,
                          color: AppColors.fieldLabel,
                          size: 24.r,
                        ),
                        validator: (v) => AppValidators.validateConfirmPassword(
                          v,
                          _passwordController.text,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      TermsAgreement(
                        isChecked: _agreeToTerms,
                        onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                        onTermsTap: () {},
                        onPrivacyTap: () {},
                      ),
                      SizedBox(height: 24.h),

                      AppButton(
                        variant: AppButtonVariant.elevated,
                        label: AppStrings.authDoctorSignupCreateAccountButton.tr(),
                        onPressed: _onCreateAccount,
                        isLoading: isLoading,
                        suffixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowRight01,
                          color: colors.onPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.authDoctorSignupAlreadyHaveProfile.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                          ),
                          AppButton(
                            variant: AppButtonVariant.text,
                            label: AppStrings.authDoctorSignupLogIn.tr(),
                            onPressed: _onLogIn,
                            expanded: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
