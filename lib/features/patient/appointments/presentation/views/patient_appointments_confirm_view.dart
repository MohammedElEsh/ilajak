import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/widgets/row_text_button_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/elevated_button_booking_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/text_field_notes_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/time_item_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/date_item_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/doctor_card_describtion_widget.dart';

class PatientAppointmentsConfirmView extends StatefulWidget {
  const PatientAppointmentsConfirmView({super.key});

  @override
  State<PatientAppointmentsConfirmView> createState() =>
      _PatientAppointmentsConfirmViewState();
}

class _PatientAppointmentsConfirmViewState
    extends State<PatientAppointmentsConfirmView> {
  final DateTime now = DateTime.now();

  DateTime get lastDay => DateTime(now.year, now.month + 1, 0);

  int get daysCount => lastDay.day - now.day + 1;

  late DateTime selectedDate = now;
  int selectedIndexTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: AppStrings.homeAppBarTitle.tr(),
        leadingWidget: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        actionWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 23),
              child: DoctorCardDescribtionWidget(),
            ),

            SizedBox(height: 8.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: RowTextButtonWidget(
                title: "Select Date",
                buttonText: DateFormat('MMMM yyyy').format(now),
                onTap: () {},
              ),
            ),

            SizedBox(height: 16.h),

            SizedBox(
              height: 80.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                scrollDirection: Axis.horizontal,
                itemCount: daysCount,
                itemBuilder: (context, index) {
                  final date = now.add(Duration(days: index));

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: DateItem(
                        date: date,
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        isSelected:
                            selectedDate.year == date.year &&
                            selectedDate.month == date.month &&
                            selectedDate.day == date.day,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Available Time",
                style: AppTypography.semiBold22.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TimeItemWidget(
                    isSelected: selectedIndexTime == index,
                    onTap: () {
                      setState(() {
                        selectedIndexTime = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 35.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Symptoms/Notes (Optional)",
                style: AppTypography.semiBold22.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFieldNotesWidget(),
            ),
            SizedBox(height: 30.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Payment',
                        style: AppTypography.regular13.copyWith(
                          color: AppColors.darkMint,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$45.00',
                        style: AppTypography.semiBold22.copyWith(
                          color: AppColors.backgroundDark,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButtonBookingWidget(
                    text: 'Confirm Booking',
                    width: 180.w,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
