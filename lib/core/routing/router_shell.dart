import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/shared/layout/bottom_nav_bar.dart';

class RouterShell extends StatelessWidget {
  const RouterShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  int _branchOffset(UserRole role) {
    return role == UserRole.doctor ? 5 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final sessionManager = sl<SessionManager>();
    final role = sessionManager.role;
    final offset = _branchOffset(role);
    final normalizedIndex = navigationShell.currentIndex - offset;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(
              role: role,
              currentIndex: normalizedIndex,
              onTap: (index) => navigationShell.goBranch(
                index + offset,
                initialLocation: index == normalizedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
