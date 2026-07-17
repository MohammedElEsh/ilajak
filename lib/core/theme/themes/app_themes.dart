import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

abstract class AppThemes {
  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;
}
