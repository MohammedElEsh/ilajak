import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final Widget? leadingWidget;
  final Widget? actionWidget;
  final Widget? titleWidget;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
    this.leadingWidget,
    this.actionWidget,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 210.w,
      leading: Row(
        children: [
          leadingWidget ?? const SizedBox.shrink(),
          SizedBox(width: 12.w),
          Expanded(child: titleWidget ?? const SizedBox.shrink()),
        ],
      ),
      actions: [actionWidget ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
