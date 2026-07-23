import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class AddMedicationButtomWidget extends StatelessWidget {
  const AddMedicationButtomWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.listTileArrowIcon,
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          radius: Radius.circular(16.r),
        ),
        child: Container(
          height: 60.h,
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 24.sp, color: AppColors.textPrimaryLight),
              SizedBox(width: 8.w),
              Text(
                AppStrings.addMedication.tr(),
                style: AppTypography.medium16.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
