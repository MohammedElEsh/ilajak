import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/routing/router_guard.dart';
import 'package:ilajak/core/routing/router_shell.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/features/auth/data/repositories/auth_repository.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_forgot_password_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_login_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_register_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_reset_password_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_verify_otp_cubit.dart';
import 'package:ilajak/features/auth/presentation/views/forgot_password_view.dart';
import 'package:ilajak/features/auth/presentation/views/login_view.dart';
import 'package:ilajak/features/auth/presentation/views/reset_password_view.dart';
import 'package:ilajak/features/auth/presentation/views/signup_view.dart';
import 'package:ilajak/features/auth/presentation/views/role_selection_view.dart';
import 'package:ilajak/features/auth/presentation/views/verify_otp_view.dart';
import 'package:ilajak/features/doctor/articles/presentation/views/doctor_articles_view.dart';
import 'package:ilajak/features/doctor/home/presentation/views/doctor_home_view.dart';
import 'package:ilajak/features/doctor/notifications/presentation/views/doctor_notifications_view.dart';
import 'package:ilajak/features/doctor/patients/presentation/views/doctor_patients_view.dart';
import 'package:ilajak/features/doctor/profile/presentation/views/doctor_profile_view.dart';
import 'package:ilajak/features/patient/appointments/data/repos/doctors_repo.dart';
import 'package:ilajak/features/patient/appointments/presentation/manager/cubits/doctors_cubit.dart';
import 'package:ilajak/features/patient/health/presentation/views/health_view.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_cubit.dart';
import 'package:ilajak/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/my_appointments_view.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/patient_appointments_view.dart';
import 'package:ilajak/features/patient/health/presentation/views/labs_view.dart';
import 'package:ilajak/features/patient/home/presentation/views/patient_home_view.dart';
import 'package:ilajak/features/patient/notifications/presentation/views/patient_notifications_view.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/manager/prescription_cubit.dart';
import 'package:ilajak/features/patient/prescriptions/presentation/views/patient_prescriptions_view.dart';
import 'package:ilajak/features/patient/profile/data/models/profile_model.dart';
import 'package:ilajak/features/patient/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_change_password_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_health_info_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_personal_info_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_profile_view.dart';
import 'package:ilajak/features/patient/radiology/presentation/views/radiology_results_view.dart';

late final GoRouter appRouter;

void initRouter() {
  final guard = RouterGuard(sl<SessionManager>());

  appRouter = GoRouter(
    navigatorKey: FeedbackHandler.navigatorKey,
    initialLocation: guard.initialLocation,
    refreshListenable: guard.refreshListenable,
    redirect: guard.redirect,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OnboardingCubit>(),
          child: const OnboardingView(),
        ),
      ),
      GoRoute(
        // extra is ProfileModel
        path: RouteNames.patientPersonalInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: PatientPersonalInfoView(
            profile: state.extra as ProfileModel,
          ),
        ),
      ),
      GoRoute(
        path: RouteNames.patientChangePassword,
        builder: (context, state) => const PatientChangePasswordView(),
      ),
      GoRoute(
        path: RouteNames.patientHealthInfo,
        builder: (context, state) => const PatientHealthInfoView(),
      ),
      GoRoute(
        path: RouteNames.patientRadiologyResults,
        builder: (context, state) => const RadiologyResultsView(),
      ),
      GoRoute(
        path: RouteNames.patientLabResults,
        builder: (context, state) => const LabResultsView(),
      ),
      GoRoute(
        path: RouteNames.patientPrescriptions,
        builder: (context, state) => BlocProvider(
          create: (_) => PrescriptionCubit(),
          child: const PatientPrescriptionsView(),
        ),
      ),

      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthLoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: RouteNames.roleSelection,
        builder: (context, state) => const RoleSelectionView(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthRegisterCubit>(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthForgotPasswordCubit(sl<AuthRepository>()),
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: RouteNames.verifyOtp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => AuthVerifyOtpCubit(sl<AuthRepository>()),
            child: VerifyOtpView(email: email),
          );
        },
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final email = extra['email'] as String? ?? '';
          final otp = extra['otp'] as String? ?? '';
          return BlocProvider(
            create: (_) => AuthResetPasswordCubit(sl<AuthRepository>()),
            child: ResetPasswordView(email: email, otp: otp),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RouterShell(navigationShell: navigationShell),
        branches: [
          // ─── Patient branches ─────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientHome,
                builder: (context, state) => const PatientHomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientAppointments,
                builder: (context, state) => BlocProvider(
                  create: (context) =>
                      DoctorsCubit(doctorsRepo: sl<DoctorsRepo>()),
                  child: const PatientAppointmentsView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientHealth,
                builder: (context, state) => const HealthView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientNotifications,
                builder: (context, state) => const PatientNotificationsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientProfile,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<ProfileCubit>()..getProfile(),
                  child: const PatientProfileView(),
                ),
              ),
            ],
          ),
          // ─── Doctor branches ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorHome,
                builder: (context, state) => const DoctorHomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorPatients,
                builder: (context, state) => const DoctorPatientsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorArticles,
                builder: (context, state) => const DoctorArticlesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorNotifications,
                builder: (context, state) => const DoctorNotificationsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorProfile,
                builder: (context, state) => const DoctorProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.patientMyAppointments,
        builder: (context, state) => const MyAppointmentsView(),
      ),
    ],
  );
}
