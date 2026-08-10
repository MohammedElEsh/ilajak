import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/data/models/doctors_model.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctor_available_time_slots_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/book_appointment_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/patient_appointments_confirm_view.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/elevated_button_booking_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/info_box_widget.dart';

class DoctorCardWidget extends StatelessWidget {
  const DoctorCardWidget({
    super.key,
    this.doctor,
    this.onTap,
  });
  final DoctorModel? doctor;
  
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage(
                    doctor?.avatar ?? AppAssets.profileImage,
                  ),
                ),

                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor?.name ?? 'Dr. Elena Rodriguez',
                        style: AppTypography.semiBold18,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        doctor?.specialization ?? "Neurologist",
                        style: AppTypography.medium16.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          doctor?.averageRating.toString() ?? "5.0",
                          style: AppTypography.semiBold18,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      doctor?.reviews.toString() ?? "98 Reviews",
                      style: AppTypography.medium16.copyWith(
                        color: AppColors.fieldLabel,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: InfoBoxWidget(
                    title: "Experience",
                    value: doctor?.experience.toString() ?? "12 Years",
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: InfoBoxWidget(
                    title: "Patients",
                    value: doctor?.totalPatients.toString() ?? "2.4k+",
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: InfoBoxWidget(
                    title: "Availability",
                    value: doctor?.availability.toString() ?? "Tomorrow",
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            ElevatedButtonBookingWidget(
              text: AppStrings.bookAppointment.tr(),
              onTap: () {
                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => DoctorAvailableTimeSlotsCubit(
                                          doctorsRepo: sl<DoctorsRepo>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) => BookAppointmentCubit(
                                          sl<DoctorsRepo>(),
                                        ),
                                      ),
                                    ],
                                    child: PatientAppointmentsConfirmView(
                                     doctor: doctor!,
                                    ),
                                  ),
                                ),
                              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
