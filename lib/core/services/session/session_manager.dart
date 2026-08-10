import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/services/auth/token_refresher.dart';
import 'package:ilajak/core/services/auth/token_service.dart';
import 'package:ilajak/core/services/logger/logger_service.dart';
import 'package:ilajak/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { patient, doctor }

/// High-level application flow states.
///
/// These are the ONLY states the router reasons about.
/// UI screens are NOT allowed to make routing decisions.
enum AppStatus {
  /// Initial value before [SessionManager.initialize] completes.
  /// Treated like [onboardingRequired] for routing purposes.
  initial,

  /// First-launch state: the user has not completed onboarding.
  onboardingRequired,

  /// Onboarding done, but the user is not authenticated.
  unauthenticated,

  /// User is authenticated, but has not yet acknowledged the
  /// post-login "getting started" screen.
  authenticatedNeedsSetup,

  /// User is authenticated and fully ready.
  authenticated,
}

class SessionManager extends ChangeNotifier {
  final SharedPreferences prefs;
  final TokenService tokenService;
  final TokenRefresher tokenRefresher;

  SessionManager(this.prefs, this.tokenService, this.tokenRefresher);

  static const _onboardingKey = 'onboarding_done';
  static const _roleSelectedKey = 'role_selected';
  static const _roleKey = 'user_role';
  static const _userDataKey = 'user_data';

  AppStatus _status = AppStatus.initial;

  /// 🎭 UI Preview → doctor | patient
  //  _role = doctor      →  shows doctor UI; change to patient for patient UI
  UserRole _role = UserRole.patient;

  bool get onboardingDone => prefs.getBool(_onboardingKey) ?? false;
  bool get isRoleSelected => prefs.getBool(_roleSelectedKey) ?? false;

  AppStatus get status => _status;
  UserRole get role => _role;

  void setRole(UserRole role) {
    _role = role;
    prefs.setString(_roleKey, role.name);
    prefs.setBool(_roleSelectedKey, true);
    notifyListeners();
  }

  /// 🚀 DEV ONLY — Set `true` to skip Onboarding & Login
  //  _bypassAuth = true  →  skips onboarding & login, opens app directly
  static const _bypassAuth = false;

  /// 🔑 Startup session restore strategy.
  /// - `false` (default): a persisted access token is enough to restore the
  ///   session (auto-login). Best for APIs without a refresh token.
  /// - `true`: requires a persisted refresh token and exchanges it proactively;
  ///   logs the user out if the refresh token is missing/expired.
  static const _proactiveStartupRefresh = false;

  /// Called once at app startup — inspects persistent storage
  /// and decides the initial app flow state.
  ///
  /// Flow:
  /// 1. Onboarding not done → onboardingRequired
  /// 2. No tokens stored → unauthenticated
  /// 3. Has tokens → proactive refresh:
  ///    - Refresh succeeds (200) → authenticated
  ///    - Refresh fails with 401 (refresh token expired) → logout → unauthenticated
  ///    - Refresh fails with network/other error → authenticated (assume token still valid,
  ///      let the interceptor handle 401 on actual API calls)
  Future<void> initialize() async {
    final savedRole = prefs.getString(_roleKey);
    if (savedRole != null) {
      _role = UserRole.values.firstWhere(
        (r) => r.name == savedRole,
        // orElse: () => UserRole.patient,
      );
    }

    if (_bypassAuth) {
      LoggerService.i(
        'SessionManager.initialize — bypass: opening home directly',
        tag: 'SessionManager',
      );
      _status = AppStatus.authenticated;
      notifyListeners();
      return;
    }

    if (!onboardingDone) {
      LoggerService.i(
        'SessionManager.initialize — onboarding not done',
        tag: 'SessionManager',
      );
      _status = AppStatus.onboardingRequired;
      notifyListeners();
      return;
    }

    final accessToken = await tokenService.getAccessToken();
    final refreshToken = await tokenService.getRefreshToken();

    if (accessToken == null || accessToken.isEmpty) {
      LoggerService.i(
        'SessionManager.initialize — no access token stored',
        tag: 'SessionManager',
      );
      _status = AppStatus.unauthenticated;
      notifyListeners();
      return;
    }

    // ── Proactive refresh at startup (optional) ────────────────────────────
    // When enabled, a stored refresh token is exchanged upfront for a fresh
    // access token and the session is only kept if that succeeds. Disabled by
    // default so the app can auto-login from a persisted access token alone,
    // even when the API provides no refresh token.
    if (_proactiveStartupRefresh) {
      // ── ORIGINAL FLOW (kept for reuse in projects with a refresh token) ──
      if (refreshToken == null || refreshToken.isEmpty) {
        LoggerService.i(
          'SessionManager.initialize — no tokens stored',
          tag: 'SessionManager',
        );
        _status = AppStatus.unauthenticated;
        notifyListeners();
        return;
      }

      LoggerService.i(
        'SessionManager.initialize — proactive token refresh...',
        tag: 'SessionManager',
      );

      final result = await tokenRefresher.refresh();

      if (result.isRight()) {
        LoggerService.i(
          'SessionManager.initialize — proactive refresh succeeded',
          tag: 'SessionManager',
        );
        _status = AppStatus.authenticated;
      } else {
        final isAuthFailure = result.fold(
          (failure) =>
              failure is AuthFailure ||
              (failure is ServerFailure && failure.statusCode == 401),
          (_) => false,
        );

        if (isAuthFailure) {
          LoggerService.w(
            'SessionManager.initialize — refresh token expired (401), logging out',
            tag: 'SessionManager',
          );
          _status = AppStatus.unauthenticated;
        } else {
          result.fold(
            (failure) => LoggerService.w(
              'SessionManager.initialize — refresh failed (network/other), '
              'treating as authenticated. Interceptor will handle 401 on '
              'actual requests. Failure: $failure',
              tag: 'SessionManager',
            ),
            (_) => null,
          );
          _status = AppStatus.authenticated;
        }
      }
    } else {
      // ── SIMPLE FLOW (default) ────────────────────────────────────────────
      // A persisted access token is enough to restore the session. Refresh is
      // best-effort only and never degrades the restored session.
      LoggerService.i(
        'SessionManager.initialize — access token found, restoring session',
        tag: 'SessionManager',
      );
      _status = AppStatus.authenticated;

      if (refreshToken != null && refreshToken.isNotEmpty) {
        LoggerService.i(
          'SessionManager.initialize — proactive token refresh...',
          tag: 'SessionManager',
        );
        final result = await tokenRefresher.refresh();
        if (result.isRight()) {
          LoggerService.i(
            'SessionManager.initialize — proactive refresh succeeded',
            tag: 'SessionManager',
          );
        } else {
          result.fold(
            (failure) => LoggerService.w(
              'SessionManager.initialize — proactive refresh failed, '
              'keeping session. Failure: $failure',
              tag: 'SessionManager',
            ),
            (_) => null,
          );
        }
      }
    }

    notifyListeners();
  }

  // ─── Setup ───────────────────────────────────────────────────────────────

  /// Marks the post-login setup as completed.
  /// Transitions from [AppStatus.authenticatedNeedsSetup]
  /// to [AppStatus.authenticated], letting the router send the user home.
  ///
  /// Idempotent: calling this from any other state is a no-op.
  Future<void> markReady() async {
    if (_status != AppStatus.authenticatedNeedsSetup) {
      LoggerService.w(
        'markReady() called from non-setup state: $_status',
        tag: 'SessionManager',
      );
      return;
    }
    _status = AppStatus.authenticated;
    notifyListeners();
  }

  // ─── Onboarding ──────────────────────────────────────────────────────────

  Future<void> completeOnboarding() async {
    await prefs.setBool(_onboardingKey, true);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }

  // ─── Auth ────────────────────────────────────────────────────────────────

  /// Persists the tokens and transitions to [AppStatus.authenticatedNeedsSetup].
  /// The router will then redirect the user to the "getting started" screen.
  ///
  /// Pass [skipSetup] = true to transition directly to [AppStatus.authenticated]
  /// (straight to the home screen) — used while the getting-started screen
  /// does not exist yet.
  Future<void> login({
    required String accessToken,
    String? refreshToken,
    bool skipSetup = false,
  }) async {
    LoggerService.i('login() — saving tokens', tag: 'SessionManager');
    await tokenService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    _status = skipSetup
        ? AppStatus.authenticated
        : AppStatus.authenticatedNeedsSetup;
    notifyListeners();
  }

  Future<void> saveUserData(UserModel user) async {
    LoggerService.i(
      'saveUserData() — caching user data',
      tag: 'SessionManager',
    );
    await prefs.setString(_userDataKey, jsonEncode(user.toJson()));
  }

  UserModel? getUserData() {
    final jsonString = prefs.getString(_userDataKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        return UserModel.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>,
        );
      } catch (e) {
        LoggerService.e(
          'Failed to parse cached user data',
          error: e,
          tag: 'SessionManager',
        );
        return null;
      }
    }
    return null;
  }

  Future<void> logout() async {
    LoggerService.w(
      'logout() — clearing tokens and user data',
      tag: 'SessionManager',
    );
    await tokenService.clearTokens();
    await prefs.remove(_userDataKey);
    _status = AppStatus.unauthenticated;
    notifyListeners();
  }
}
