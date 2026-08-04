import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// `router_shell.dart` draws `BottomNavBar` as a `Positioned` overlay on
/// top of each branch's content (`Stack([navigationShell, Positioned(...)])`)
/// instead of using `Scaffold.bottomNavigationBar`. That means NOTHING
/// automatically reserves space for it — any screen with content near the
/// bottom (a button row, a FAB, the last card in a list) needs to leave
/// this much room manually, or the nav bar visually sits on top of it.
///
/// `BottomNavBar` itself is `NavigationBar(height: 64.h)` wrapped in a
/// `SafeArea` — so the real space it occupies is that fixed height plus
/// whatever bottom safe-area inset the device has (e.g. the home-indicator
/// area on iPhones).
///
/// Use `context.bottomNavClearance` anywhere you'd otherwise guess a
/// bottom padding/offset — e.g.:
///   SizedBox(height: 24.h + context.bottomNavClearance)   // trailing scroll padding
///   Positioned(bottom: 16.h + context.bottomNavClearance, ...)   // a manual FAB
extension BottomNavClearanceX on BuildContext {
  double get bottomNavClearance => 64.h + MediaQuery.of(this).padding.bottom;
}
