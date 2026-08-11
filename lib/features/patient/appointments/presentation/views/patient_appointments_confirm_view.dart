import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/widgets/row_text_button_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/book_appointment_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctor_available_time_slots_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctor_available_time_slots_state.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/book_appointment_state.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/patient_appointments_success.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/elevated_button_booking_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/text_field_notes_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/time_item_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/date_item_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/doctor_card_describtion_widget.dart';

class PatientAppointmentsConfirmView extends StatefulWidget {
  final DoctorModel doctor;
  const PatientAppointmentsConfirmView({super.key, required this.doctor});

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
  String time = "";
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
              child: DoctorCardDescribtionWidget(doctor: widget.doctor),
            ),

            SizedBox(height: 8.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: RowTextButtonWidget(
                title: AppStrings.selectDate.tr(),
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
                            context
                                .read<DoctorAvailableTimeSlotsCubit>()
                                .getAvailableTimeSlots(
                                  widget.doctor.id,
                                  selectedDate,
                                );
                            debugPrint(selectedDate.toString());
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
                AppStrings.availableTime.tr(),
                style: AppTypography.semiBold22.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            BlocConsumer<
              DoctorAvailableTimeSlotsCubit,
              DoctorAvailableTimeSlotsState
            >(
              listener: (context, state) {
                if (state is DoctorAvailableTimeSlotsError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                if (state is DoctorAvailableTimeSlotsLoading) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is DoctorAvailableTimeSlotsError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is DoctorAvailableTimeSlotsLoaded) {
                  if (state.timeSlots.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Text(
                          'Doctor does not work on this day.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.timeSlots.length,
                      itemBuilder: (context, index) {
                        return TimeItemWidget(
                          isSelected: selectedIndexTime == index,
                          time: state.timeSlots[index],
                          onTap: () {
                            setState(() {
                              selectedIndexTime = index;
                              time = state.timeSlots[index];
                              debugPrint(state.timeSlots[index].toString());
                            });
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Text(
                        'Doctor does not work on this day.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 35.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                AppStrings.symptomsNotes.tr(),
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
                        AppStrings.totalPayment.tr(),
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
                  BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
                    listener: (context, state) {
                      if (state is BookAppointmentError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      } else if (state is BookAppointmentSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PatientAppointmentsSuccessView(
                                  doctor: widget.doctor,
                                  date: DateFormat(
                                    'dd MMM, yyyy',
                                  ).format(selectedDate),
                                  time: time,
                                ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is BookAppointmentLoading) {
                        return SizedBox(
                          width: 180.w,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ElevatedButtonBookingWidget(
                        text: AppStrings.confirmBooking.tr(),
                        width: 180.w,
                        onTap: () {
                          if (time.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a time slot'),
                              ),
                            );
                            return;
                          }
                          context
                              .read<BookAppointmentCubit>()
                              .bookAppointment(
                                doctorId: widget.doctor.id,
                                clinicId: widget.doctor.clinicId,
                                date: DateFormat(
                                  'yyyy-MM-dd',
                                ).format(selectedDate),
                                slotTime: time,
                              );
                        },
                      );
                    },
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
