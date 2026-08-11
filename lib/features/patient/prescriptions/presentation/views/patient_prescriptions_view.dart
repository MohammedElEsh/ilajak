import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/shared/loading/app_loading.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/manager/prescription_cubit.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/manager/prescription_state.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/views/prescription_detail_view.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/widgets/prescription_card_widget.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/widgets/prescription_filter_tabs.dart';

class PatientPrescriptionsView extends StatefulWidget {
  const PatientPrescriptionsView({super.key});

  @override
  State<PatientPrescriptionsView> createState() =>
      _PatientPrescriptionsViewState();
}

class _PatientPrescriptionsViewState extends State<PatientPrescriptionsView> {
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<PrescriptionCubit>().getPrescriptions();
  }

  void _onFilterSelected(int index) {
    setState(() => _selectedFilterIndex = index);
    const statuses = ['all', 'active', 'completed', 'expiring_soon'];
    context.read<PrescriptionCubit>().filterByStatus(statuses[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                AppStrings.prescriptionsTitle.tr(),
                style: AppTypography.bold28.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.prescriptionsSubtitle.tr(),
                style: AppTypography.regular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20.h),

              PrescriptionFilterTabs(
                selectedIndex: _selectedFilterIndex,
                onTabSelected: _onFilterSelected,
              ),
              SizedBox(height: 16.h),

              Expanded(
                child: BlocBuilder<PrescriptionCubit, PrescriptionState>(
                  builder: (context, state) {
                    if (state is PrescriptionLoading) {
                      return const AppLoading();
                    }

                    if (state is PrescriptionError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedAlertCircle,
                              size: 48.sp,
                              color: AppColors.error,
                              strokeWidth: 1.5,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              state.message,
                              style: AppTypography.regular14.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is PrescriptionSuccess) {
                      if (state.prescriptions.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedPrescriptions,
                                  size: 64.sp,
                                  color: AppColors.grey4,
                                  strokeWidth: 1.5,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  AppStrings.prescriptionsNoPrescriptions.tr(),
                                  style: AppTypography.semiBold18.copyWith(
                                    color: AppColors.textPrimaryLight,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  AppStrings
                                      .prescriptionsNoPrescriptionsSubtitle
                                      .tr(),
                                  style: AppTypography.regular14.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 24.h),
                        itemCount: state.prescriptions.length,
                        itemBuilder: (context, index) {
                          final prescription = state.prescriptions[index];
                          return PrescriptionCardWidget(
                            prescription: prescription,
                            onView: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PrescriptionDetailView(
                                    prescription: prescription,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
