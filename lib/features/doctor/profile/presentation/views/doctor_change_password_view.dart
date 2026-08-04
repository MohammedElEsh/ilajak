import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_clearance.dart';
import 'package:ilajak/core/theme/colors/app_color_scheme.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/core/utils/app_validators.dart';

class DoctorChangePasswordView extends StatefulWidget {
  const DoctorChangePasswordView({super.key});

  @override
  State<DoctorChangePasswordView> createState() => _DoctorChangePasswordViewState();
}

class _DoctorChangePasswordViewState extends State<DoctorChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Extends the shared AppValidators.validatePassword (length-only) with the
  // number + symbol requirement from the mock's helper text, without
  // changing the shared validator's behavior for login/signup.
  String? _validateNewPassword(String? value) {
    final lengthError = AppValidators.validatePassword(value, minLength: 8);
    if (lengthError != null) return lengthError;
    final hasDigit = RegExp(r'\d').hasMatch(value!);
    final hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]').hasMatch(value);
    if (!hasDigit || !hasSymbol) {
      return AppStrings.doctorChangePasswordComplexityError.tr();
    }
    return null;
  }

  void _onUpdatePassword() {
    if (!_formKey.currentState!.validate()) return;
    // TODO(backend): call the change-password API with the three
    // controllers' values once it exists.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: context.appColors.primary, size: 22.sp),
          ),
          titleWidget: Text(
            AppStrings.doctorChangePasswordTitle.tr(),
            style: AppTypography.semiBold18.copyWith(color: context.appColors.primary),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    AppStrings.doctorChangePasswordIntro.tr(),
                    style: AppTypography.regular16.copyWith(color: context.appColors.textSecondary),
                  ),
                  SizedBox(height: 24.h),

                  _FieldLabel(AppStrings.doctorChangePasswordCurrent.tr()),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: _currentPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) => AppValidators.validatePassword(value, minLength: 0),
                  ),
                  SizedBox(height: 20.h),

                  _FieldLabel(AppStrings.doctorChangePasswordNew.tr()),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: _newPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    validator: _validateNewPassword,
                  ),
                  SizedBox(height: 20.h),

                  _FieldLabel(AppStrings.doctorChangePasswordConfirm.tr()),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: _confirmPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) => AppValidators.validateConfirmPassword(
                      value,
                      _newPasswordController.text,
                    ),
                  ),
                  SizedBox(height: 18.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: context.appColors.primaryLight2,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, size: 18.sp, color: context.appColors.primary),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            AppStrings.doctorChangePasswordHint.tr(),
                            style: AppTypography.regular14.copyWith(color: context.appColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  AppButton(
                    label: AppStrings.doctorChangePasswordUpdateButton.tr(),
                    variant: AppButtonVariant.elevated,
                    onPressed: _onUpdatePassword,
                  ),
                  SizedBox(height: 16.h),

                  Center(
                    child: TextButton(
                      onPressed: () => context.push(RouteNames.forgotPassword),
                      child: Text(
                        AppStrings.doctorChangePasswordForgot.tr(),
                        style: AppTypography.semiBold14.copyWith(color: context.appColors.primary),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),

                  Center(
                    child: Opacity(
                      opacity: .06,
                      child: Icon(Icons.lock_reset, size: 160.sp, color: context.appColors.primary),
                    ),
                  ),
                  SizedBox(height: 24.h + context.bottomNavClearance),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.medium12.copyWith(color: context.appColors.textSecondary, letterSpacing: .5),
    );
  }
}
