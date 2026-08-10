import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/session/session_manager.dart';
import '../../../../core/shared/inputs/app_text_field.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/utils/app_validators.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.formKey,
    required this.role,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.nationalIdController,
    required this.medicalIdController,
    required this.dateOfBirthController,
    required this.genderValue,
    required this.onGenderChanged,
    required this.bloodTypeValue,
    required this.onBloodTypeChanged,
    required this.addressController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final UserRole role;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController nationalIdController;
  final TextEditingController medicalIdController;
  final TextEditingController dateOfBirthController;
  final String? genderValue;
  final ValueChanged<String?> onGenderChanged;
  final String? bloodTypeValue;
  final ValueChanged<String?> onBloodTypeChanged;
  final TextEditingController addressController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colors.onSurfaceVariant,
    );

    final fields = <Widget>[
      Text(AppStrings.authSignupName.tr(), style: labelStyle),
      SizedBox(height: 8.h),
      AppTextField(
        controller: nameController,
        hint: AppStrings.authSignupName.tr(),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        prefixIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedUser,
          color: AppColors.fieldLabel,
          size: 24.r,
        ),
        validator: AppValidators.validateName,
      ),
      if (role == UserRole.doctor) ...[
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupMedicalId.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField(
          controller: medicalIdController,
          hint: AppStrings.authSignupMedicalIdHint.tr(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedId,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupMedicalId.tr(),
          ),
        ),
      ],
      SizedBox(height: 20.h),
      Text(AppStrings.authLoginEmail.tr(), style: labelStyle),
      SizedBox(height: 8.h),
      AppTextField(
        controller: emailController,
        hint: AppStrings.authLoginEmailHint.tr(),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        prefixIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedMail01,
          color: AppColors.fieldLabel,
          size: 24.r,
        ),
        validator: AppValidators.validateEmail,
      ),
    ];

    if (role == UserRole.patient) {
      fields.addAll([
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupPhone.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField(
          controller: phoneController,
          hint: AppStrings.authSignupPhoneHint.tr(),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedCall02,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          validator: AppValidators.validatePhone,
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupNationalId.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField(
          controller: nationalIdController,
          hint: AppStrings.authSignupNationalIdHint.tr(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedId,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupNationalId.tr(),
          ),
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupDateOfBirth.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField(
          controller: dateOfBirthController,
          hint: AppStrings.authSignupDateOfBirthHint.tr(),
          type: AppTextFieldType.date,
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedCalendar01,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          locale: context.locale,
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupDateOfBirth.tr(),
          ),
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupGender.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField<String>(
          type: AppTextFieldType.dropdown,
          dropdownValue: genderValue,
          hint: AppStrings.authSignupGenderHint.tr(),
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedManWoman,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          dropdownItems: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onDropdownChanged: onGenderChanged,
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupGender.tr(),
          ),
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupBloodType.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField<String>(
          type: AppTextFieldType.dropdown,
          dropdownValue: bloodTypeValue,
          hint: AppStrings.authSignupBloodTypeHint.tr(),
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedDroplet,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          dropdownItems: const [
            DropdownMenuItem(value: 'A+', child: Text('A+')),
            DropdownMenuItem(value: 'A-', child: Text('A-')),
            DropdownMenuItem(value: 'B+', child: Text('B+')),
            DropdownMenuItem(value: 'B-', child: Text('B-')),
            DropdownMenuItem(value: 'O+', child: Text('O+')),
            DropdownMenuItem(value: 'O-', child: Text('O-')),
            DropdownMenuItem(value: 'AB+', child: Text('AB+')),
            DropdownMenuItem(value: 'AB-', child: Text('AB-')),
          ],
          onDropdownChanged: onBloodTypeChanged,
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupBloodType.tr(),
          ),
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.authSignupAddress.tr(), style: labelStyle),
        SizedBox(height: 8.h),
        AppTextField(
          controller: addressController,
          hint: AppStrings.authSignupAddressHint.tr(),
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedLocation01,
            color: AppColors.fieldLabel,
            size: 24.r,
          ),
          validator: (value) => AppValidators.validateRequiredField(
            value,
            fieldName: AppStrings.authSignupAddress.tr(),
          ),
        ),
      ]);
    }

    fields.addAll([
      SizedBox(height: 20.h),
      Text(AppStrings.authSignupPassword.tr(), style: labelStyle),
      SizedBox(height: 8.h),
      AppTextField(
        controller: passwordController,
        hint: AppStrings.authSignupPasswordHint.tr(),
        isPassword: true,
        textInputAction: TextInputAction.next,
        prefixIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedSquareLock01,
          color: AppColors.fieldLabel,
          size: 24.r,
        ),
        validator: AppValidators.validatePassword,
      ),
      SizedBox(height: 20.h),
      Text(AppStrings.authSignupConfirmPassword.tr(), style: labelStyle),
      SizedBox(height: 8.h),
      AppTextField(
        controller: confirmPasswordController,
        hint: AppStrings.authSignupConfirmPassword.tr(),
        isPassword: true,
        textInputAction: TextInputAction.done,
        prefixIcon: HugeIcon(
          icon: HugeIcons.strokeRoundedSquareLock01,
          color: AppColors.fieldLabel,
          size: 24.r,
        ),
        validator: (value) => AppValidators.validateConfirmPassword(
          value,
          passwordController.text,
        ),
      ),
    ]);

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields,
        ),
      ),
    );
  }
}
