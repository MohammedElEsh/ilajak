import 'package:flutter/material.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';

/// Theme-aware color roles for the Doctor screens (and anything else that
/// adopts this pattern going forward).
///
/// WHY THIS EXISTS: AppColors only defines ONE value for several roles
/// used throughout the Doctor screens (e.g. `primaryLight2`, `secondary`,
/// `textSecondary`, `divider`, `listTileArrowIcon`) — there was never a
/// dark-mode counterpart to swap to. Reading `AppColors.xxx` directly (as
/// every screen built so far does) means the color is frozen regardless
/// of `Theme.of(context).brightness`, even though `app.dart` already
/// drives `ThemeMode.system` with a fully-built `AppThemes.dark`.
///
/// This extension is the missing bridge: register `AppColorScheme.light`
/// on `lightTheme` and `AppColorScheme.dark` on `darkTheme` (see the two
/// `extensions: [...]` lines added to light_theme.dart / dark_theme.dart),
/// then read colors via `context.appColors.xxx` instead of `AppColors.xxx`
/// anywhere the color should actually change with the theme.
///
/// FLAGGED FOR DESIGN REVIEW: the fields marked "NEW" below don't have an
/// existing dark value anywhere in the codebase — I picked reasonable
/// dark-mode-appropriate colors so nothing renders unreadable (e.g. a
/// near-white `primaryLight2` tint would look like a rendering bug on a
/// near-black background), but these are my placeholders, not an
/// approved palette. Swap the hex values below once you (or a designer)
/// settle on the real dark palette — nothing else needs to change.
@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.primary,
    required this.primaryLight,
    required this.primaryLight2,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.error,
    required this.success,
    required this.listTileArrowIcon,
    required this.grey4,
  });

  final Color primary;
  final Color primaryLight;
  final Color primaryLight2;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color error;
  final Color success;
  final Color listTileArrowIcon;
  final Color grey4;

  /// Exact same values AppColors/light_theme.dart already use — no
  /// visual change for light mode.
  static const light = AppColorScheme(
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryLight2: AppColors.primaryLight2,
    secondary: AppColors.secondary,
    surface: AppColors.surfaceLight,
    background: AppColors.backgroundLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondary,
    divider: AppColors.divider,
    error: AppColors.error,
    success: AppColors.success,
    listTileArrowIcon: AppColors.listTileArrowIcon,
    grey4: AppColors.grey4,
  );

  /// primary / surface / background / textPrimary / error / grey4 reuse
  /// the exact values dark_theme.dart already defines (unchanged from the
  /// existing dark ColorScheme). Everything else below is NEW — see the
  /// class doc comment.
  static const dark = AppColorScheme(
    primary: AppColors.primary, // unchanged — matches dark_theme.dart's colorScheme.primary
    primaryLight: Color(0xFF6FA8E8), // NEW — brightened so it still reads on a dark surface
    primaryLight2: Color(0xFF16324D), // NEW — dark desaturated navy, replaces the near-white tint
    secondary: Color(0xFF23364C), // NEW — dark version of the pale chip/avatar background
    surface: AppColors.surfaceDark, // unchanged — matches dark_theme.dart's colorScheme.surface
    background: AppColors.backgroundDark, // unchanged — matches dark_theme.dart's scaffoldBackgroundColor
    textPrimary: AppColors.textPrimaryDark, // unchanged — matches dark_theme.dart's onSurface
    textSecondary: Color(0xFFB0B8C4), // NEW — the light-mode slate gray is unreadable on near-black
    divider: Color(0xFF2A2E38), // NEW — a subtle line on a dark surface instead of near-white
    error: AppColors.error, // unchanged — matches dark_theme.dart (kept constant across both)
    success: AppColors.success, // unchanged — dark_theme.dart never redefines this either
    listTileArrowIcon: Color(0xFF6B7280), // NEW — reuses AppColors.fieldLabel's tone, legible on dark
    grey4: AppColors.grey4, // unchanged — dark_theme.dart reuses the same grey scale as-is
  );

  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryLight2,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? textPrimary,
    Color? textSecondary,
    Color? divider,
    Color? error,
    Color? success,
    Color? listTileArrowIcon,
    Color? grey4,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryLight2: primaryLight2 ?? this.primaryLight2,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
      error: error ?? this.error,
      success: success ?? this.success,
      listTileArrowIcon: listTileArrowIcon ?? this.listTileArrowIcon,
      grey4: grey4 ?? this.grey4,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryLight2: Color.lerp(primaryLight2, other.primaryLight2, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      listTileArrowIcon: Color.lerp(listTileArrowIcon, other.listTileArrowIcon, t)!,
      grey4: Color.lerp(grey4, other.grey4, t)!,
    );
  }
}

/// `context.appColors.primary` etc. Falls back to the light palette if the
/// extension isn't registered on the active theme (shouldn't happen once
/// both theme files are updated, but keeps this file safe on its own).
extension AppColorSchemeX on BuildContext {
  AppColorScheme get appColors =>
      Theme.of(this).extension<AppColorScheme>() ?? AppColorScheme.light;
}
