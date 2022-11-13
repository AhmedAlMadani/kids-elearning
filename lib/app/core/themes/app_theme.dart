import 'package:flutter/material.dart';
import 'package:kiddo/app/core/themes/text_theme.dart';

import '../values/colors.dart';

abstract class AppThemeData {
  static final ThemeData _baseTheme = ThemeData(
    primaryColor: primary,
    backgroundColor: background,
    scaffoldBackgroundColor: background,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: appTextTheme,
    dialogBackgroundColor: white,
  );

  static ThemeData getThemeData() {
    return _baseTheme;
  }
}
