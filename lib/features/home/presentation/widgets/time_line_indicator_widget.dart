import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

class TimeLineIndicatorWidget extends StatelessWidget {
  const TimeLineIndicatorWidget({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.primary,
          child: Image.asset(icon, width: 20.w, height: 20.h),
        ),
        Container(width: 2.w, height: 60.h, color: Colors.grey.shade300),
      ],
    );
  }
}
