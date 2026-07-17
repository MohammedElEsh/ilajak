// =============================================================================
// DARK THEME — Source of Truth for Dark Mode
// =============================================================================
//
// RULES:
// 1. All values here are FIXED (no ScreenUtil .sp / .w / .h).
//    ThemeData is built BEFORE ScreenUtilInit runs, so using .sp causes
//    LateInitializationError.
//
// 2. To make a widget responsive, apply ScreenUtil at the WIDGET level:
//    - Padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h)
//    - Font:    TextStyle(fontSize: 16.sp)
//    - Radius:  BorderRadius.circular(12.r)
//
// 3. To change a color/font globally, edit THIS file + light_theme.dart.
//    All themed widgets (AppButton, AppTextField, etc.) pick it up automatically.
//
// 4. Component widgets resolve values in this priority:
//    widget.param > theme.property > colorScheme/textTheme fallback
// =============================================================================

import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../typography/app_typography.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  // ── Color Scheme ──────────────────────────────────────────────────────────
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.surfaceDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.surfaceDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceContainerHighest: AppColors.grey2,
    outlineVariant: AppColors.grey2,
    onSurfaceVariant: AppColors.grey3,
    error: AppColors.error,
    onError: AppColors.surfaceDark,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,

  // ── Typography ────────────────────────────────────────────────────────────
  textTheme: TextTheme(
    displayLarge: AppTypography.bold36,
    headlineLarge: AppTypography.extraBold24,
    headlineMedium: AppTypography.semiBold20,
    headlineSmall: AppTypography.semiBold18,
    bodyLarge: AppTypography.regular14,
    bodyMedium: AppTypography.semiBold14,
    labelLarge: AppTypography.regular14,
    labelMedium: AppTypography.regular12,
    labelSmall: AppTypography.regular12,
  ).apply(
    bodyColor: AppColors.textPrimaryDark,
    displayColor: AppColors.textPrimaryDark,
  ),

  // ── AppBar ────────────────────────────────────────────────────────────────
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTypography.semiBold18,
  ),

  // ── Icons ─────────────────────────────────────────────────────────────────
  iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),

  // ── Divider ───────────────────────────────────────────────────────────────
  dividerTheme: const DividerThemeData(color: AppColors.grey2),

  // ── Card ──────────────────────────────────────────────────────────────────
  cardTheme: CardThemeData(
    color: AppColors.surfaceDark,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // ── Buttons (ElevatedButton / AppButton uses this) ────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surfaceDark,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: AppTypography.semiBold18,
    ),
  ),

  // ── Outlined Button ───────────────────────────────────────────────────────
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.surfaceDark,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: const BorderSide(color: AppColors.surfaceDark),
      textStyle: AppTypography.semiBold14,
    ),
  ),

  // ── Text Button ───────────────────────────────────────────────────────────
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: AppTypography.regular14,
    ),
  ),

  // ── Icon Button ───────────────────────────────────────────────────────────
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.textPrimaryDark,
      padding: const EdgeInsets.all(8),
    ),
  ),

  // ── Input Decoration (AppTextField uses this) ─────────────────────────────
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceDark,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    hintStyle: AppTypography.regular12.copyWith(color: AppColors.grey3),
  ),

  // ── Bottom Navigation Bar ─────────────────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.grey3,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // ── Checkbox ──────────────────────────────────────────────────────────────
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.surfaceDark),
    side: const BorderSide(color: AppColors.grey2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  // ── Radio ─────────────────────────────────────────────────────────────────
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return AppColors.grey2;
    }),
  ),

  // ── Switch ────────────────────────────────────────────────────────────────
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColors.primary;
      return AppColors.grey2;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary.withValues(alpha: .4);
      }
      return AppColors.grey2;
    }),
  ),

  // ── Chip ──────────────────────────────────────────────────────────────────
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.grey2,
    selectedColor: AppColors.primary.withValues(alpha: .12),
    labelStyle: AppTypography.regular12,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    side: BorderSide.none,
  ),

  // ── FAB ───────────────────────────────────────────────────────────────────
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.surfaceDark,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // ── Tab Bar ───────────────────────────────────────────────────────────────
  tabBarTheme: TabBarThemeData(
    indicatorColor: AppColors.primary,
    labelColor: AppColors.primary,
    unselectedLabelColor: AppColors.grey3,
    labelStyle: AppTypography.semiBold14,
    unselectedLabelStyle: AppTypography.regular14,
    dividerColor: AppColors.grey2,
  ),

  // ── Slider ────────────────────────────────────────────────────────────────
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.grey2,
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primary.withValues(alpha: .12),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
  ),

  // ── Progress Indicator ────────────────────────────────────────────────────
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.grey2,
    circularTrackColor: AppColors.grey2,
  ),

  // ── SnackBar ──────────────────────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    contentTextStyle:
        AppTypography.regular14.copyWith(color: AppColors.textPrimaryDark),
    actionTextColor: AppColors.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 6,
    behavior: SnackBarBehavior.floating,
  ),

  // ── Dialog ────────────────────────────────────────────────────────────────
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surfaceDark,
    titleTextStyle:
        AppTypography.semiBold20.copyWith(color: AppColors.textPrimaryDark),
    contentTextStyle:
        AppTypography.regular14.copyWith(color: AppColors.textPrimaryDark),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 8,
  ),

  // ── Popup Menu ────────────────────────────────────────────────────────────
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.surfaceDark,
    textStyle:
        AppTypography.regular14.copyWith(color: AppColors.textPrimaryDark),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  ),

  // ── List Tile ─────────────────────────────────────────────────────────────
  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    titleTextStyle:
        AppTypography.semiBold14.copyWith(color: AppColors.textPrimaryDark),
    subtitleTextStyle: AppTypography.regular12.copyWith(color: AppColors.grey3),
    iconColor: AppColors.textPrimaryDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Badge ─────────────────────────────────────────────────────────────────
  badgeTheme: BadgeThemeData(
    backgroundColor: AppColors.primary,
    textColor: AppColors.surfaceDark,
    textStyle: AppTypography.regular12,
  ),

  // ── Tooltip ───────────────────────────────────────────────────────────────
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: AppColors.textPrimaryDark,
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: AppTypography.regular12.copyWith(color: AppColors.surfaceDark),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),

  // ── Expansion Tile ────────────────────────────────────────────────────────
  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: AppColors.surfaceDark,
    collapsedBackgroundColor: AppColors.surfaceDark,
    iconColor: AppColors.textPrimaryDark,
    collapsedIconColor: AppColors.grey3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // ── Navigation Bar (Material 3) ───────────────────────────────────────────
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    indicatorColor: Colors.transparent,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTypography.semiBold14.copyWith(color: AppColors.primary);
      }
      return AppTypography.semiBold14.copyWith(color: AppColors.grey3);
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: AppColors.primary);
      }
      return const IconThemeData(color: AppColors.grey3);
    }),
  ),

  // ── Bottom Sheet ──────────────────────────────────────────────────────────
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.surfaceDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    elevation: 8,
  ),

  // ── Drawer ────────────────────────────────────────────────────────────────
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.surfaceDark,
    elevation: 8,
    shape: RoundedRectangleBorder(),
  ),

  // ── Scrollbar ─────────────────────────────────────────────────────────────
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(AppColors.grey2),
    trackColor: WidgetStateProperty.all(AppColors.grey2),
    thickness: WidgetStateProperty.all(6),
    radius: const Radius.circular(3),
  ),

  // ── Dropdown Menu ─────────────────────────────────────────────────────────
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle:
        AppTypography.regular14.copyWith(color: AppColors.textPrimaryDark),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.surfaceDark),
      elevation: WidgetStateProperty.all(4),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  ),

  // ── Segmented Button ──────────────────────────────────────────────────────
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      selectedForegroundColor: AppColors.primary,
      selectedBackgroundColor: AppColors.primary.withValues(alpha: .12),
      textStyle: AppTypography.regular14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // ── Search Bar ────────────────────────────────────────────────────────────
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(AppColors.surfaceDark),
    hintStyle: WidgetStateProperty.all(
        AppTypography.semiBold14.copyWith(color: AppColors.textSecondary)),
    textStyle: WidgetStateProperty.all(
        AppTypography.semiBold14.copyWith(color: AppColors.textPrimaryDark)),
    elevation: WidgetStateProperty.all(0),
    shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
    padding:
        WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
  ),

  // ── Menu Button ───────────────────────────────────────────────────────────
  menuButtonTheme: MenuButtonThemeData(
    style: MenuItemButton.styleFrom(
      foregroundColor: AppColors.textPrimaryDark,
      textStyle: AppTypography.regular14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
);
