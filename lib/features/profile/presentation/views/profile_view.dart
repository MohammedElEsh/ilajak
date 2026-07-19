import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_constants.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        actionWidget: IconButton(
          onPressed: () {},
          icon: Icon(
            HugeIcons.strokeRoundedSearch02,
            color: AppColors.primary,
            size: 24.r,
          ),
        ),
        leadingWidget: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppAssets.profileImage),
                radius: 16.r,
              ),
              SizedBox(width: 4.w),
              Text(AppConstants.appName, style: AppTypography.bold16),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Profile', style: TextStyle(fontSize: 24.sp)),
        ),
      ),
    );
  }
}
