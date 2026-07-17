import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../services/session/session_manager.dart';
import '../shared/feedback/feedback_handler.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/patients/presentation/views/patients_view.dart';
import '../../features/articles/presentation/views/articles_view.dart';
import '../../features/notifications/presentation/views/notifications_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import 'route_names.dart';
import 'router_guard.dart';
import 'router_shell.dart';

late final GoRouter appRouter;

void initRouter() {
  final guard = RouterGuard(sl<SessionManager>());

  appRouter = GoRouter(
    navigatorKey: FeedbackHandler.navigatorKey,
    initialLocation: guard.initialLocation,
    refreshListenable: guard.refreshListenable,
    redirect: guard.redirect,
    routes: [
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
