import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../services/session/session_manager.dart';
import '../shared/feedback/feedback_handler.dart';

import 'router_guard.dart';

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
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('ilajak')),
        ),
      ),
    ],
  );
}
