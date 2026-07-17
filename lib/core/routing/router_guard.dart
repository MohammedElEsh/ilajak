import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/session/session_manager.dart';
import 'route_names.dart';

/// Pure translator from [AppStatus] → route.
///
/// The guard never decides "is this screen allowed?".
/// It only asks: "given the current state, what screen SHOULD the user be on,
/// and is the current screen either that screen or a sibling of it?"
///
/// There are no blocked/allowed permission lists.
/// Every piece of routing logic is keyed on [AppStatus] only.
class RouterGuard {
  final SessionManager _sessionManager;

  RouterGuard(this._sessionManager);

  ChangeNotifier get refreshListenable => _sessionManager;

  String get initialLocation => _homeRouteFor(_sessionManager.status);

  String? redirect(BuildContext _, GoRouterState state) {
    final status = _sessionManager.status;
    final location = state.uri.path;

    // The canonical home route for the current state is always allowed.
    if (location == _homeRouteFor(status)) return null;

    // Sibling routes within the same UX flow are allowed.
    if (_siblingRoutesFor(status).contains(location)) return null;

    // Otherwise, force the user to the home route for their state.
    return _homeRouteFor(status);
  }

  // ─── Mappings ────────────────────────────────────────────────────────────

  /// The ONE route a user MUST be on for a given status.
  /// This is the source of truth for "where does this state live?".
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

  /// Routes the user can navigate to WHILE still in [status] without
  /// being redirected back to the home route.
  ///
  /// These describe the "internal navigation" of a state — e.g. when
  /// unauthenticated, the user can move between login / signup / forgot-password
  /// because they are all part of the same auth flow.
  ///
  /// This is NOT a permission blacklist. If a route is not in this set,
  /// it simply means it belongs to a different state.
  Set<String> _siblingRoutesFor(AppStatus status) {
    switch (status) {
      case AppStatus.unauthenticated:
        return const {
          RouteNames.signup,
          RouteNames.forgotPassword,
        };
      case AppStatus.authenticated:
        return const {
          RouteNames.categories,
          RouteNames.cart,
          RouteNames.wishlist,
          RouteNames.profile,
        };
      case AppStatus.initial:
      case AppStatus.onboardingRequired:
      case AppStatus.authenticatedNeedsSetup:
        return const <String>{};
    }
  }
}
