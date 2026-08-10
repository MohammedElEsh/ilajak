import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class RadiologyListViewBuilder extends StatefulWidget {
  const RadiologyListViewBuilder({super.key});

  @override
  State<RadiologyListViewBuilder> createState() =>
      _RadiologyListViewBuilderState();
}

class _RadiologyListViewBuilderState extends State<RadiologyListViewBuilder> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RadiologyTypeCard(
            title: 'X-Ray',
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            isSelected: selectedIndex == index,
          );
        },
      ),
    );
  }
}

class RadiologyTypeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  const RadiologyTypeCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsetsDirectional.only(end: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.lightGray,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: AppTypography.regular16.copyWith(
            color: isSelected
                ? AppColors.surfaceLight
                : AppColors.textPrimaryLight,
          ),
        ),
      ),
    );
  }
}
