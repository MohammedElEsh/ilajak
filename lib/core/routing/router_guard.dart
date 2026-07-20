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
        return RouteNames.home;
    }
  }

  Set<String> _siblingRoutesFor(AppStatus status) {
    switch (status) {
      case AppStatus.unauthenticated:
        return const {
          RouteNames.signup,
          RouteNames.forgotPassword,
        };
      case AppStatus.authenticated:
        return const {
          RouteNames.patients,
          RouteNames.articles,
          RouteNames.notifications,
          RouteNames.profile,
          RouteNames.personalInfo,
          RouteNames.changePassword,
          RouteNames.healthInfo,
          RouteNames.emergencyContacts,
        };
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
      case AppStatus.authenticatedNeedsSetup:
        return const <String>{};
    }
  }
}
