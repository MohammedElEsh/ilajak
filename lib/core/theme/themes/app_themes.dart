import 'package:flutter/material.dart';

import 'package:ilajak/core/theme/themes/dark_theme.dart';
import 'package:ilajak/core/theme/themes/light_theme.dart';

abstract class AppThemes {
  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;
}
