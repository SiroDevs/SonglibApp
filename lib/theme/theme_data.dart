import 'package:flutter/material.dart';

import 'theme_colors.dart';

final asLightTheme = buildLightTheme();
final asDarkTheme = buildDarkTheme();

ThemeData buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: ThemeColors.primary,
    secondary: ThemeColors.primaryDark,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    //accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: ThemeColors.primary,
    //buttonColor: secondaryColor,
    //indicatorColor: ColorUtils.white,
    //toggleableActiveColor: ColorUtils.activeColor,
    //splashColor: ColorUtils.splashColor,
    //splashFactory: InkRipple.splashFactory,
    //accentColor: secondaryColor,
    //canvasColor: ColorUtils.white,
    scaffoldBackgroundColor: Colors.white,
    //backgroundColor: ColorUtils.white,
    //errorColor: Colors.red,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    //accentTextTheme: base.accentTextTheme,
  );
}

ThemeData buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: ThemeColors.primary,
    secondary: ThemeColors.primaryDark,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    //accentColorBrightness: Brightness.dark,
    //buttonColor: primaryColor,
    //indicatorColor: ColorUtils.white,
    //toggleableActiveColor: ColorUtils.activeColor2,
    //accentColor: secondaryColor,
    //canvasColor: ColorUtils.baseColor2,
    //scaffoldBackgroundColor: ColorUtils.baseColor2,
    //backgroundColor: ColorUtils.baseColor2,
    //errorColor: Colors.red,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    //accentTextTheme: base.accentTextTheme,
  );
}
