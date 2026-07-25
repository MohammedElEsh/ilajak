import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    if (location == _homeRouteFor(status)) return null;

    if (_siblingRoutesFor(status).contains(location)) return null;

    return _homeRouteFor(status);
  }

  String _homeRouteFor(AppStatus status) {
    switch (status) {
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
        return RouteNames.onboarding;
      case AppStatus.unauthenticated:
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
          RouteNames.signup,
          RouteNames.forgotPassword,
          RouteNames.verifyOtp,
        };
      case AppStatus.authenticated:
        return const {
          // Patient routes
          RouteNames.patientHome,
          RouteNames.patientAppointments,
          RouteNames.patientArticles,
          RouteNames.patientNotifications,
          RouteNames.patientProfile,
          // Doctor routes
          RouteNames.doctorHome,
          RouteNames.doctorPatients,
          RouteNames.doctorArticles,
          RouteNames.doctorNotifications,
          RouteNames.doctorProfile,
          // Patient profile sub-routes
          RouteNames.patientPersonalInfo,
          RouteNames.patientChangePassword,
          RouteNames.patientHealthInfo,
          RouteNames.patientEmergencyContacts,
          
          RouteNames.patientAppointmentsConfirm,
          RouteNames.patientAppointmentsSuccess,

        };
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
      case AppStatus.authenticatedNeedsSetup:
        return const <String>{};
    }
  }
}
