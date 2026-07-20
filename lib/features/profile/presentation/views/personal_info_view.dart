import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/profile/presentation/widgets/personal_info_form.dart';
import 'package:ilajak/features/profile/presentation/widgets/profile_image_avatar.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.personalInfoTitle.tr(),
        centerTitle: true,
        leadingWidget: IconButton(
          // constraints: BoxConstraints.tightFor(width: 22.w, height: 22.h),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        actionWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Image.asset(AppAssets.imageProfile, width: 40.w, height: 40.h),
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
                Text('Mohamed Ehab', style: AppTypography.semiBold22),
                SizedBox(height: 4.h),
                Text('Member since Oct 2023', style: AppTypography.medium12),
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

