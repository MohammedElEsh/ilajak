import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final Widget? actionWidget;
  final Widget? leadingWidget;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
    this.actionWidget,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 120.w,
      // ProfileImage circle avatar
      leading: leadingWidget ?? SizedBox.shrink(),
      actions: [
        actionWidget ?? SizedBox.shrink(),
        SizedBox(width: 8.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
