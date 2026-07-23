import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
          style: AppTypography.regular14.copyWith(fontSize: 16.sp),
          hint: Text(
            AppStrings.gender.tr(),
            style: AppTypography.regular14.copyWith(fontSize: 16.sp),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: [
            DropdownMenuItem(
              value: AppStrings.male.tr(),
              child: Text(AppStrings.male.tr()),
            ),
            DropdownMenuItem(
              value: AppStrings.female.tr(),
              child: Text(AppStrings.female.tr()),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
      ),
    );
  }
}