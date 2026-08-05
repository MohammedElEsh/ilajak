import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class BirthDateWidget extends StatefulWidget {
  const BirthDateWidget({super.key, required this.birthDate});
  final String birthDate;

  @override
  State<BirthDateWidget> createState() => _BirthDateWidgetState();
}

class _BirthDateWidgetState extends State<BirthDateWidget> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final initial = selectedDate ??
        DateTime.tryParse(widget.birthDate) ??
        DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  String _getFormattedDate() {
    final dateToFormat = selectedDate ?? DateTime.tryParse(widget.birthDate);
    if (dateToFormat != null) {
      return DateFormat('yyyy-MM-dd').format(dateToFormat);
    }
    return widget.birthDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickDate(),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 56.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.grey4, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 20.sp),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                _getFormattedDate(),
                style: AppTypography.regular14.copyWith(fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
