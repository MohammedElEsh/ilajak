import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ilajak/core/constants/app_strings.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/shared/feedback/app_error_widget.dart';
import 'package:ilajak/core/shared/layout/app_top_bar.dart';
import 'package:ilajak/core/shared/loading/app_loading.dart';
import 'package:ilajak/core/shared/chips/app_filter_chip.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_cubit.dart';
import 'package:ilajak/features/doctor/medical_records/logic/doctor_medical_records_cubit/doctor_medical_records_state.dart';
import 'package:ilajak/features/doctor/medical_records/presentation/widgets/medical_record_list_tile.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_cubit.dart';
import 'package:ilajak/features/doctor/prescriptions/logic/doctor_prescriptions_cubit/doctor_prescriptions_state.dart';
import 'package:ilajak/features/doctor/prescriptions/presentation/widgets/prescription_list_tile.dart';

enum _RecordsFilter { all, labResults, radiology, prescriptions }

/// TODO(backend): the header (avatar / name / "Patient ID") still shows
/// [patientName] only — no doctor-facing "get patient personal info"
/// endpoint exists yet to fill in age/gender/a real patient ID label (see
/// backend gaps shipped with this feature).
class DoctorPatientRecordsView extends StatefulWidget {
  const DoctorPatientRecordsView({
    super.key,
    required this.patientId,
    this.patientName,
  });

  final int patientId;
  final String? patientName;

  @override
  State<DoctorPatientRecordsView> createState() =>
      _DoctorPatientRecordsViewState();
}

class _DoctorPatientRecordsViewState extends State<DoctorPatientRecordsView> {
  static const _filterKeys = [
    AppStrings.doctorPatientRecordsFilterAll,
    AppStrings.doctorPatientRecordsFilterLabResults,
    AppStrings.doctorPatientRecordsFilterRadiology,
    AppStrings.doctorPatientRecordsFilterPrescriptions,
  ];
  static const _filters = [
    _RecordsFilter.all,
    _RecordsFilter.labResults,
    _RecordsFilter.radiology,
    _RecordsFilter.prescriptions,
  ];

  int _selectedFilterIndex = 0;

  late final DoctorMedicalRecordsCubit _medicalRecordsCubit;
  late final DoctorPrescriptionsCubit _prescriptionsCubit;

  @override
  void initState() {
    super.initState();
    _medicalRecordsCubit = sl<DoctorMedicalRecordsCubit>()
      ..loadRecords(patientId: widget.patientId);
    _prescriptionsCubit = sl<DoctorPrescriptionsCubit>()
      ..loadPrescriptions(patientId: widget.patientId);
  }

  @override
  void dispose() {
    _medicalRecordsCubit.close();
    _prescriptionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = _filters[_selectedFilterIndex];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _medicalRecordsCubit),
        BlocProvider.value(value: _prescriptionsCubit),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Scaffold(
          appBar: AppTopBar(
            leadingWidget: CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.primaryLight2,
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedHospital01,
                size: 20.sp,
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
            ),
            titleWidget: Text(
              AppStrings.doctorHomeAppBarTitle.tr(),
              style: AppTypography.semiBold18.copyWith(
                color: AppColors.primary,
              ),
            ),
            actionWidget: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              size: 24.sp,
              color: AppColors.primary,
              strokeWidth: 1.5,
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            width: 64.w,
                            height: 64.h,
                            color: AppColors.secondary,
                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                              size: 30.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.patientName ??
                                    '${AppStrings.doctorPatientRecordsPatientIdPrefix.tr()}${widget.patientId}',
                                style: AppTypography.semiBold22.copyWith(
                                  color: AppColors.textPrimaryLight,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${AppStrings.doctorPatientRecordsPatientIdPrefix.tr()}${widget.patientId}',
                                style: AppTypography.regular14.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filterKeys.length,
                        separatorBuilder: (_, _) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          return AppFilterChip(
                            label: _filterKeys[index].tr(),
                            selected: index == _selectedFilterIndex,
                            onTap: () =>
                                setState(() => _selectedFilterIndex = index),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(child: _buildList(context, selectedFilter)),
                  ],
                ),
                // NOTE: positioned manually because RouterShell draws the
                // BottomNavBar as an overlay, not Scaffold.bottomNavigationBar.
                Positioned(
                  right: 0,
                  bottom: 16.h + MediaQuery.of(context).padding.bottom,
                  child: FloatingActionButton(
                    onPressed: () async {
                      final created = await context.push<bool>(
                        RouteNames.doctorCreateMedicalRecordFullPath,
                        extra: widget.patientId,
                      );
                      if (created == true) {
                        _medicalRecordsCubit.loadRecords(
                          patientId: widget.patientId,
                        );
                      }
                    },
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      Icons.add,
                      color: AppColors.surfaceLight,
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, _RecordsFilter filter) {
    if (filter == _RecordsFilter.prescriptions) {
      return BlocBuilder<DoctorPrescriptionsCubit, DoctorPrescriptionsState>(
        builder: (context, state) {
          if (state is DoctorPrescriptionsLoading ||
              state is DoctorPrescriptionsInitial) {
            return const AppLoading();
          }
          if (state is DoctorPrescriptionsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () => _prescriptionsCubit.loadPrescriptions(
                patientId: widget.patientId,
              ),
            );
          }
          final prescriptions = state is DoctorPrescriptionsLoaded
              ? state.prescriptions
              : const [];
          if (prescriptions.isEmpty) {
            return Center(
              child: Text(
                AppStrings.doctorPrescriptionsEmpty.tr(),
                style: AppTypography.regular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: prescriptions.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            padding: EdgeInsets.only(bottom: 90.h + MediaQuery.of(context).padding.bottom),
            itemBuilder: (context, index) =>
                PrescriptionListTile(prescription: prescriptions[index]),
          );
        },
      );
    }

    return BlocBuilder<DoctorMedicalRecordsCubit, DoctorMedicalRecordsState>(
      builder: (context, state) {
        if (state is DoctorMedicalRecordsLoading ||
            state is DoctorMedicalRecordsInitial) {
          return const AppLoading();
        }
        if (state is DoctorMedicalRecordsError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () =>
                _medicalRecordsCubit.loadRecords(patientId: widget.patientId),
          );
        }
        final allRecords = state is DoctorMedicalRecordsLoaded
            ? state.records
            : const [];
        final records = switch (filter) {
          _RecordsFilter.labResults =>
            allRecords.where((r) => r.hasLabResults).toList(),
          _RecordsFilter.radiology =>
            allRecords.where((r) => r.hasRadiologyResults).toList(),
          _ => allRecords,
        };

        if (records.isEmpty) {
          return Center(
            child: Text(
              AppStrings.doctorMedicalRecordsEmpty.tr(),
              style: AppTypography.regular14.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          );
        }
        return ListView.separated(
          itemCount: records.length,
          separatorBuilder: (_, _) => SizedBox(height: 16.h),
          padding: EdgeInsets.only(bottom: 90.h + MediaQuery.of(context).padding.bottom),
          itemBuilder: (context, index) =>
              MedicalRecordListTile(record: records[index]),
        );
      },
    );
  }
}
