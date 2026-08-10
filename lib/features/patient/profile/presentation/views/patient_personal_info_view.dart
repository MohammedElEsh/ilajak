import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/profile/data/models/profile_model.dart';
import 'package:ilajak/features/patient/profile/presentation/widgets/personal_info_form.dart';
import 'package:ilajak/features/patient/profile/presentation/widgets/profile_image_avatar.dart';

class PatientPersonalInfoView extends StatelessWidget {
  const PatientPersonalInfoView({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.personalInfoTitle.tr(),
        centerTitle: true,
        leadingWidget: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        actionWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                const ProfileImageAvatar(),
                SizedBox(height: 16.h),
                Text(profile.name, style: AppTypography.semiBold22),
                SizedBox(height: 4.h),
                Text(profile.email, style: AppTypography.medium12),
                SizedBox(height: 64.h),
                const PersonalInfoForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
