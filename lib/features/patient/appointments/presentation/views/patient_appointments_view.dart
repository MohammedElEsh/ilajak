import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_assets.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/widgets/row_text_button_widget.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctors_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctors_details_cubit.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/states/doctors_state.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/patient_doctor_profile_view.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/container_of_specialization.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/doctor_card_booking_widget.dart';
import 'package:ilajak/features/patient/appointments/presentation/widgets/search_field_widget.dart';

class PatientAppointmentsView extends StatefulWidget {
  const PatientAppointmentsView({super.key});

  @override
  State<PatientAppointmentsView> createState() =>
      _PatientAppointmentsViewState();
}

class _PatientAppointmentsViewState extends State<PatientAppointmentsView> {
  int selectedIndex = 0;
  final specializations = [
    "All",
    "Cardiology",
    "Pediatric Cardiologist",
    "General Practitioner",
    "Pediatrics",
    "Ophthalmology",
    "Orthopedics",
    "Gynecology",
    "Urology",
    "Oncology",
  ];
  Timer? _debounce; // علشان ااخر عمليه البحث شويه
  String searchQuery = '';
  // الميثود دي بتتنده كل مره اليوزر يكتب حرف
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false)
      _debounce!.cancel(); //لو فيه Timer شغال من الحرف اللي قبله، الغيه.
    _debounce = Timer(const Duration(milliseconds: 500), () {
      //تنتظر 500 ملي ثانية بعد آخر ضغطة زر
      setState(() {
        searchQuery = query;
      });
      _fetchDoctors();
    });
  }

  void _fetchDoctors() {
    if (selectedIndex == 0) {
      if (searchQuery.isNotEmpty) {
        BlocProvider.of<DoctorsCubit>(
          context,
        ).getDoctors(search: searchQuery);
      } else {
         BlocProvider.of<DoctorsCubit>(
          context,
        ).getDoctors();
      }
    } else {
      BlocProvider.of<DoctorsCubit>(
        context,
      ).getDoctors(
        search: searchQuery.isNotEmpty ? searchQuery : null,
        specialization: specializations[selectedIndex],
      );
    }
  }

  @override
  void initState() {
    super.initState();
      BlocProvider.of<DoctorsCubit>(
          context,
        ).getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Scaffold(
        appBar: AppTopBar(
          leadingWidget: CircleAvatar(
            radius: 20.r,
            backgroundImage: const AssetImage(AppAssets.profileImage),
          ),
          actionWidget: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            size: 24.sp,
            color: AppColors.primary,
            strokeWidth: 1.5,
          ),
          titleWidget: Text(
            AppStrings.homeAppBarTitle.tr(),
            style: AppTypography.bold28.copyWith(color: AppColors.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SearchFieldWidget(
                        hintText: AppStrings.searchDoctorsSymptoms.tr(),
                        onChanged: _onSearchChanged,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedCardExchange01,
                          size: 30,
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      specializations.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: ContainerOfSpecialization(
                          text: specializations[index],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            _fetchDoctors();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35.h),
                RowTextButtonWidget(
                  title: AppStrings.recommendedDoctors.tr(),
                  buttonText: "156 Found",
                  onTap: () {},
                ),
                SizedBox(height: 24.h),
                BlocConsumer<DoctorsCubit, DoctorsState>(
                  listener: (context, state) {
                    if (state is DoctorsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DoctorsLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is DoctorsError) {
                      return Center(child: Text(state.errorMessage));
                    }

                    if (state is DoctorsLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          return DoctorCardWidget(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => DoctorsDetailsCubit(
                                      doctorsRepo: sl<DoctorsRepo>(),
                                    ),
                                    child: PatientDoctorProfileView(
                                      doctorId: state.doctors[index].id,
                                    ),
                                  ),
                                ),
                              );
                            },
                            doctor: state.doctors[index],
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
