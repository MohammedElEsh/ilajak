import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/buttons/app_button.dart';
import 'package:ilajak/core/shared/inputs/app_text_field.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/profile/presentation/manager/cubit/profile_cubit.dart';
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
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w).copyWith(bottom: 16.h),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          // Loading
          if (state is GetPersonalInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Error
          if (state is GetPersonalInfoError) {
            return Center(child: Text(state.error));
          }
          // Success
          if (state is GetPersonalInfoSuccess) {
            final currentUser = state.user;
            return Column(
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
                  hint: currentUser.name ?? 'Mohamed Ehab',
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
                  hint: currentUser.email ?? 'meehab74@gmail.com',
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
                  hint: currentUser.phone ?? '+201060589547',
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
                          BirthDateWidget(
                            birthDate: currentUser.dob ?? '1/1/2000',
                          ),
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
