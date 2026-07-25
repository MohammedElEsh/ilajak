import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/profile/presentation/widgets/birth_date_widget.dart';
import 'package:ilajak/features/patient/profile/presentation/widgets/gender_widget.dart';
import 'package:ilajak/features/patient/profile/presentation/widgets/profile_hint_message.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w).copyWith(bottom: 16.h),
      child: Column(
        children: [
          // Full Name
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.fullName.tr(),
              style: AppTypography.medium14,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            hint: 'Mohamed Ehab',
            isPassword: false,
            suffixIcon: Icon(
              Icons.person_outline,
              color: AppColors.listTileArrowIcon,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 24.h),
          // Email Address
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.emailAddress.tr(),
              style: AppTypography.medium14,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            hint: 'meehab74@gmail.com',
            isPassword: false,
            suffixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.listTileArrowIcon,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 24.h),
          // Phone Number
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.phoneNumber.tr(),
              style: AppTypography.medium14,
            ),
          ),
          SizedBox(height: 8.h),
          AppTextField(
            hint: '+20 123 456 7890',
            isPassword: false,
            suffixIcon: Icon(
              Icons.phone_outlined,
              color: AppColors.listTileArrowIcon,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 48.h),
          // Date of Birth and Gender Row
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column of Date of birth
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.birthDate.tr(),
                        style: AppTypography.medium14,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const BirthDateWidget(),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Column of Gender
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.gender.tr(),
                        style: AppTypography.medium14,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const GenderWidget(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 66.h),
          ProfileHintMessage(
            iconData: Icons.shield,
            message: AppStrings.secureInfo.tr(),
          ),
          SizedBox(height: 64.h),
          // Save Changes Button
          AppButton(
            label: AppStrings.saveChanges.tr(),
            onPressed: () {},
            variant: AppButtonVariant.elevated,
          ),
        ],
      ),
    );
  }
}
