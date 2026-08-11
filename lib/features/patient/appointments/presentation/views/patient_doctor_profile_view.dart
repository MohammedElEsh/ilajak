import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctors_details_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctors_details_state.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/doctor_info_card_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/info_box_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/icon_list_tile_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/clinic_card_widget.dart';

class PatientDoctorProfileView extends StatefulWidget {
  const PatientDoctorProfileView({super.key, required this.doctorId});
  final int doctorId;

  @override
  State<PatientDoctorProfileView> createState() =>
      _PatientDoctorProfileViewState();
}

class _PatientDoctorProfileViewState extends State<PatientDoctorProfileView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DoctorsDetailsCubit>(
      context,
    ).getSingleDoctorDetails(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsDetailsCubit, DoctorsDetailsState>(
      listener: (context, state) {
        if (state is DoctorsDetailsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },

      builder: (context, state) {
        if (state is DoctorsDetailsLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DoctorsDetailsError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is DoctorsDetailsLoaded) {
          return Scaffold(
            backgroundColor: AppColors.backgroundLight,
            appBar: AppTopBar(
              title: AppStrings.homeAppBarTitle.tr(),
              leadingWidget: IconButton(
                onPressed: () => context.pop(),
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
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultation",
                        style: AppTypography.regular12.copyWith(
                          color: AppColors.fieldLabel,
                        ),
                      ),
                      Text(
                        "\$ ${state.doctorDetails.consultationFee}",
                        style: AppTypography.bold20.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: ElevatedButtonBookingWidget(
                      text: 'Book Appointment',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.profileImage),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200.h),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        DoctorInfoCardWidget(
                          name: state.doctorDetails.name,
                          specialization: state.doctorDetails.specialization,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              const Expanded(
                                child: InfoBoxWidget(
                                  title: "Experience",
                                  value: "12 Years",
                                  color: AppColors.surfaceLight,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              const Expanded(
                                child: InfoBoxWidget(
                                  title: "Patients",
                                  value: "10k+",
                                  color: AppColors.surfaceLight,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              const Expanded(
                                child: InfoBoxWidget(
                                  title: "Certificates",
                                  value: "24",
                                  color: AppColors.surfaceLight,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About Doctor",
                                style: AppTypography.semiBold18,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                state.doctorDetails.bio,
                                style: AppTypography.regular14.copyWith(
                                  color: AppColors.fieldLabel,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              IconListTileWidget(
                                icon: Icons.email,
                                title: "Email",
                                subtitle: state.doctorDetails.email,
                              ),
                              SizedBox(height: 16.h),
                              IconListTileWidget(
                                icon: Icons.phone,
                                title: "Phone",
                                subtitle: state.doctorDetails.phone,
                              ),

                              SizedBox(height: 24.h),

                              Text("Clinics", style: AppTypography.semiBold18),
                              SizedBox(height: 12.h),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.doctorDetails.clinics.length,
                                itemBuilder: (context, index) {
                                  return ClinicCardWidget(
                                    name:
                                        state.doctorDetails.clinics[index].name,
                                    address: state
                                        .doctorDetails
                                        .clinics[index]
                                        .address,
                                    phone: state
                                        .doctorDetails
                                        .clinics[index]
                                        .phone,
                                    availability:
                                        index <
                                            state.doctorDetails.schedules.length
                                        ? state
                                              .doctorDetails
                                              .schedules[index]
                                              .dayOfWeek
                                        : 'N/A',
                                  );
                                },
                              ),

                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
