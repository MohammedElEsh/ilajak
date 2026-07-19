import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final Widget leadingWidget;
  final Widget actionWidget;
  final Widget titleWidget;

  const AppTopBar({
    super.key,
    this.onMenuTap,
    this.onProfileTap,
    required this.leadingWidget,
    required this.actionWidget,
    required this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 220.w,
      leading: Row(
        children: [
          leadingWidget,
          SizedBox(width: 12.w),
          Expanded(child: titleWidget),
        ],
      ),
      actions: [actionWidget],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
