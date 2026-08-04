import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/routing/router_guard.dart';
import 'package:ilajak/core/routing/router_shell.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_forgot_password_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_login_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_register_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_verify_otp_cubit.dart';
import 'package:ilajak/features/auth/presentation/views/forgot_password_view.dart';
import 'package:ilajak/features/auth/presentation/views/login_view.dart';
import 'package:ilajak/features/auth/presentation/views/signup_view.dart';
import 'package:ilajak/features/auth/presentation/views/verify_otp_view.dart';
import 'package:ilajak/features/doctor/articles/presentation/views/doctor_articles_view.dart';
import 'package:ilajak/features/doctor/home/presentation/views/doctor_home_view.dart';
import 'package:ilajak/features/doctor/home/presentation/views/doctor_schedule_view.dart';
import 'package:ilajak/features/doctor/notifications/presentation/views/doctor_notifications_view.dart';
import 'package:ilajak/features/doctor/patients/presentation/views/doctor_patient_profile_view.dart';
import 'package:ilajak/features/doctor/patients/presentation/views/doctor_patient_records_view.dart';
import 'package:ilajak/features/doctor/patients/presentation/views/doctor_patients_view.dart';
import 'package:ilajak/features/doctor/profile/presentation/views/doctor_change_password_view.dart';
import 'package:ilajak/features/doctor/profile/presentation/views/doctor_profile_view.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_cubit.dart';
import 'package:ilajak/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:ilajak/features/patient/appointments/presentation/views/patient_appointments_view.dart';
import 'package:ilajak/features/patient/articles/presentation/views/patient_articles_view.dart';
import 'package:ilajak/features/patient/home/presentation/views/patient_home_view.dart';
import 'package:ilajak/features/patient/notifications/presentation/views/patient_notifications_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_change_password_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_health_info_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_personal_info_view.dart';
import 'package:ilajak/features/patient/profile/presentation/views/patient_profile_view.dart';

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
        path: RouteNames.patientPersonalInfo,
        builder: (context, state) => const PatientPersonalInfoView(),
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
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthLoginCubit(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthRegisterCubit(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthForgotPasswordCubit(),
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: RouteNames.verifyOtp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => AuthVerifyOtpCubit(),
            child: VerifyOtpView(email: email),
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
                builder: (context, state) => const PatientAppointmentsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patientArticles,
                builder: (context, state) => const PatientArticlesView(),
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
                builder: (context, state) => const PatientProfileView(),
              ),
            ],
          ),
          // ─── Doctor branches ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorHome,
                builder: (context, state) => const DoctorHomeView(),
                // Nested (not a sibling GoRoute) on purpose: this keeps the
                // route inside the doctorHome branch's own Navigator, so
                // pushing it leaves the shell's bottom nav bar visible with
                // "Home" still selected — matching the Schedule screen mock.
                routes: [
                  GoRoute(
                    path: RouteNames.doctorSchedule,
                    builder: (context, state) => const DoctorScheduleView(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.doctorPatients,
                builder: (context, state) => const DoctorPatientsView(),
                // Nested for the same reason as doctorSchedule above: keeps
                // the bottom nav bar visible with "Patients" selected while
                // the profile is pushed on top.
                routes: [
                  GoRoute(
                    path: RouteNames.doctorPatientProfile,
                    builder: (context, state) => const DoctorPatientProfileView(),
                    routes: [
                      GoRoute(
                        path: RouteNames.doctorPatientRecords,
                        builder: (context, state) => const DoctorPatientRecordsView(),
                      ),
                    ],
                  ),
                ],
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
                routes: [
                  GoRoute(
                    path: RouteNames.doctorChangePassword,
                    builder: (context, state) => const DoctorChangePasswordView(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
