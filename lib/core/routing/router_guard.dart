import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/services/logger/logger_service.dart';

import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/routing/route_names.dart';

class RouterGuard {
  final SessionManager _sessionManager;

  RouterGuard(this._sessionManager);

  ChangeNotifier get refreshListenable => _sessionManager;

  String get initialLocation => _homeRouteFor(_sessionManager.status);

  String? redirect(BuildContext _, GoRouterState state) {
    final status = _sessionManager.status;
    final location = state.uri.path;
    final hasSelectedRole = _sessionManager.isRoleSelected;

    LoggerService.d(' [RouterGuard.redirect] status=$status, location=$location, '
        'hasSelectedRole=$hasSelectedRole', tag: 'RouterGuard');

    if (location == _homeRouteFor(status)) {
      LoggerService.d(' [RouterGuard.redirect] Location matches home route, allowing', tag: 'RouterGuard');
      return null;
    }

    if (_siblingRoutesFor(status).contains(location)) {
      LoggerService.d(' [RouterGuard.redirect] Location is in sibling routes, allowing', tag: 'RouterGuard');
      return null;
    }

    final targetRoute = _homeRouteFor(status);
    LoggerService.d(' [RouterGuard.redirect] Redirecting to home route: $targetRoute', tag: 'RouterGuard');
    return targetRoute;
  }

  String _homeRouteFor(AppStatus status) {
    switch (status) {
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
        return RouteNames.onboarding;
      case AppStatus.unauthenticated:
        // After onboarding, user must select a role first
        if (!_sessionManager.isRoleSelected) {
          return RouteNames.roleSelection;
        }
        return RouteNames.login;
      case AppStatus.authenticatedNeedsSetup:
        return RouteNames.gettingStarted;
      case AppStatus.authenticated:
        if (_sessionManager.role == UserRole.doctor) {
          return RouteNames.doctorHome;
        }
        return RouteNames.patientHome;
    }
  }

  Set<String> _siblingRoutesFor(AppStatus status) {
    switch (status) {
      case AppStatus.unauthenticated:
        return const {
          RouteNames.login,
          RouteNames.signup,
          RouteNames.doctorSignup,
          RouteNames.roleSelection,
          RouteNames.forgotPassword,
          RouteNames.verifyOtp,
        };
      case AppStatus.authenticated:
        return {
          // Patient routes
          RouteNames.patientHome,
          RouteNames.patientAppointments,
          //RouteNames.patientArticles,
          RouteNames.patientNotifications,
          RouteNames.patientProfile,
          // Doctor routes
          RouteNames.doctorHome,
          RouteNames.doctorPatients,
          RouteNames.doctorArticles,
          RouteNames.doctorNotifications,
          RouteNames.doctorProfile,
          // Doctor sub-routes (nested under doctorHome / doctorPatients)
          RouteNames.doctorScheduleFullPath,
          RouteNames.doctorPatientProfileFullPath,
          RouteNames.doctorPatientRecordsFullPath,
          RouteNames.doctorChangePasswordFullPath,
          // Patient profile sub-routes
          RouteNames.patientPersonalInfo,
          RouteNames.patientChangePassword,
          RouteNames.patientHealthInfo,
          RouteNames.patientEmergencyContacts,
        };
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
      case AppStatus.authenticatedNeedsSetup:
        return const <String>{};
    }
  }
}
