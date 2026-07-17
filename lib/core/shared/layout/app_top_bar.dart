import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../constants/app_assets.dart';
import '../../theme/colors/app_colors.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 56.w,
      leading: IconButton(
        onPressed: onMenuTap,
        icon: HugeIcon(
          icon: HugeIcons.strokeRoundedMenu05,
          size: 28.r,
          color: AppColors.primary,
        ),
      ),
      title: Image.asset(
        AppAssets.appBarLogo,
        height: 32.h,
        fit: BoxFit.contain,
      ),
      actions: [
        IconButton(
          onPressed: onProfileTap,
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedUserSquare,
            color: AppColors.primary,
            size: 28.r,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
