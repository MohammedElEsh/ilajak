import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/routing/route_names.dart';
import 'package:ilajak/core/routing/router_guard.dart';
import 'package:ilajak/core/routing/router_shell.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/shared/feedback/feedback_handler.dart';
import 'package:ilajak/features/articles/presentation/views/articles_view.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_forgot_password_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_login_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_register_cubit.dart';
import 'package:ilajak/features/auth/presentation/manager/auth_verify_otp_cubit.dart';
import 'package:ilajak/features/auth/presentation/views/forgot_password_view.dart';
import 'package:ilajak/features/auth/presentation/views/login_view.dart';
import 'package:ilajak/features/auth/presentation/views/signup_view.dart';
import 'package:ilajak/features/auth/presentation/views/verify_otp_view.dart';
import 'package:ilajak/features/home/presentation/views/home_view.dart';
import 'package:ilajak/features/notifications/presentation/views/notifications_view.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_cubit.dart';
import 'package:ilajak/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:ilajak/features/patients/presentation/views/patients_view.dart';
import 'package:ilajak/features/profile/presentation/views/change_password_view.dart';
import 'package:ilajak/features/profile/presentation/views/health_info_view.dart';
import 'package:ilajak/features/profile/presentation/views/personal_info_view.dart';
import 'package:ilajak/features/profile/presentation/views/profile_view.dart';

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
        path: RouteNames.personalInfo,
        builder: (context, state) => const PersonalInfoView(),
      ),
      GoRoute(
        path: RouteNames.changePassword,
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        path: RouteNames.healthInfo,
        builder: (context, state) => const HealthInfoView(),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.patients,
                builder: (context, state) => const PatientsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.articles,
                builder: (context, state) => const ArticlesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.notifications,
                builder: (context, state) => const NotificationsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
