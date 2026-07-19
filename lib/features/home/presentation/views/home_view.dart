import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: Image.asset(
            AppAssets.imageProfile,
            width: 40.w,
            height: 40.h,
          ),
          actionWidget: Image.asset(
            AppAssets.searchIcon,
            width: 18.w,
            height: 18.h,
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Text(
              AppStrings.homeTitle.tr(),
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
        ),
      ),
    );
  }
}
