import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthInfoContainerWidget extends StatelessWidget {
  const HealthInfoContainerWidget({
    super.key,
    required this.childWidget,
    required this.backgroundColor,
  });
  final Widget childWidget;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      height: 40.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: childWidget,
    );
  }
}
