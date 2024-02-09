import 'package:flutter/material.dart';

import 'theme_colors.dart';

class AppThemeData {
  AppThemeData._();

  static final mainTheme = ThemeData(
    primaryColor: ThemeColors.primary,
    colorScheme: const ColorScheme(
      primary: ThemeColors.primary,
      primaryContainer: ThemeColors.primaryDark,
      onPrimary: ThemeColors.white,
      secondary: ThemeColors.accent,
      secondaryContainer: ThemeColors.accent,
      onSecondary: ThemeColors.white,
      surface: ThemeColors.grey,
      onBackground: ThemeColors.primary,
      onSurface: ThemeColors.primary,
      background: ThemeColors.grey,
      onError: ThemeColors.primaryDark,
      brightness: Brightness.light,
      error: ThemeColors.error,
    ),
    /*appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: ThemeColors.primary),
      color: ThemeColors.primary,
      toolbarTextStyle: TextStyle(color: Colors.white),
    ),*/
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeColors.accent,
      selectionHandleColor: ThemeColors.accent,
      selectionColor: ThemeColors.accent.withOpacity(0.4),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    //textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static ThemeData lightTheme(TargetPlatform? targetPlatform) {
    return mainTheme.copyWith(platform: targetPlatform);
  }
}

class AppTextTheme {
  final TextStyle titleHuge;
  final TextStyle titleBig;
  final TextStyle titleNormal;
  final TextStyle titleSmall;

  final TextStyle titleListItem;

  final TextStyle labelButtonBig;
  final TextStyle labelButtonBigDisabled;
  final TextStyle labelButtonSmall;
  final TextStyle labelButtonSmallDisabled;

  final TextStyle bodyNormal;
  final TextStyle bodySmall;
  final TextStyle bodyUltraSmall;
  final TextStyle infoBodySubHeader;
  final TextStyle bodyBig;

  const AppTextTheme({
    required this.titleHuge,
    required this.titleBig,
    required this.titleNormal,
    required this.titleSmall,
    required this.titleListItem,
    required this.labelButtonBig,
    required this.labelButtonBigDisabled,
    required this.labelButtonSmall,
    required this.labelButtonSmallDisabled,
    required this.bodyNormal,
    required this.bodySmall,
    required this.bodyUltraSmall,
    required this.infoBodySubHeader,
    required this.bodyBig,
  });
}

class AppTextThemeExceptions {
  const AppTextThemeExceptions();
}

class AppColorsTheme {
  final Color text;
  final Color inverseText;
  final Color disabledButtonText;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color inverseBackground;
  final Color inputFieldFill;
  final Color disabled;
  final Color icon;
  final Color inverseIcon;
  final Color inverseProgressIndicator;
  final Color progressIndicator;

  const AppColorsTheme({
    required this.text,
    required this.inverseText,
    required this.disabledButtonText,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.inverseBackground,
    required this.inputFieldFill,
    required this.disabled,
    required this.icon,
    required this.inverseIcon,
    required this.inverseProgressIndicator,
    required this.progressIndicator,
  });
}

class AppTheme {
  final AppTextTheme coreTextTheme;
  final AppTextTheme inverseCoreTextTheme;
  final AppTextTheme accentTextTheme;
  final AppTextThemeExceptions exceptionsTextTheme;
  final AppColorsTheme colorsTheme;

  static final instanceDark = fromColorTheme(
    colorTheme: const AppColorsTheme(
      text: ThemeColors.white,
      inverseText: ThemeColors.black,
      disabledButtonText: ThemeColors.grey,
      primary: ThemeColors.primary,
      accent: ThemeColors.accent,
      secondary: ThemeColors.white,
      background: ThemeColors.primary,
      inverseBackground: ThemeColors.white,
      inputFieldFill: ThemeColors.white,
      disabled: ThemeColors.grey,
      icon: ThemeColors.white,
      inverseIcon: ThemeColors.black,
      progressIndicator: ThemeColors.primary,
      inverseProgressIndicator: ThemeColors.white,
    ),
  );

  static final instanceLight = instanceDark;

  static AppTheme fromColorTheme({required AppColorsTheme colorTheme}) =>
      AppTheme._(
        colorsTheme: colorTheme,
        coreTextTheme: AppTextTheme(
          titleHuge:
              TextStyle(fontSize: 40, color: colorTheme.text, height: 1.2),
          titleBig:
              TextStyle(fontSize: 30, color: colorTheme.text, height: 1.2),
          titleNormal: TextStyle(fontSize: 24, color: colorTheme.text),
          titleSmall: TextStyle(fontSize: 18, color: colorTheme.text),
          titleListItem: TextStyle(
              fontSize: 18,
              color: colorTheme.text,
              fontWeight: FontWeight.bold),
          labelButtonBig: TextStyle(
              fontSize: 16,
              color: colorTheme.text,
              fontWeight: FontWeight.bold),
          labelButtonBigDisabled: TextStyle(
              fontSize: 16,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          labelButtonSmall: TextStyle(
              fontSize: 14,
              color: colorTheme.text,
              fontWeight: FontWeight.bold),
          labelButtonSmallDisabled: TextStyle(
              fontSize: 14,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          bodyBig: TextStyle(fontSize: 18, color: colorTheme.text),
          bodyNormal: TextStyle(fontSize: 16, color: colorTheme.text),
          bodySmall: TextStyle(fontSize: 14, color: colorTheme.text),
          bodyUltraSmall: TextStyle(fontSize: 12, color: colorTheme.text),
          infoBodySubHeader: TextStyle(
              fontSize: 14,
              color: colorTheme.text,
              fontWeight: FontWeight.w600),
        ),
        inverseCoreTextTheme: AppTextTheme(
          titleHuge: TextStyle(
              fontSize: 40, color: colorTheme.inverseText, height: 1.2),
          titleBig: TextStyle(
              fontSize: 30, color: colorTheme.inverseText, height: 1.2),
          titleNormal: TextStyle(fontSize: 24, color: colorTheme.inverseText),
          titleSmall: TextStyle(fontSize: 18, color: colorTheme.inverseText),
          titleListItem: TextStyle(
              fontSize: 18,
              color: colorTheme.inverseText,
              fontWeight: FontWeight.bold),
          labelButtonBig: TextStyle(
              fontSize: 16,
              color: colorTheme.inverseText,
              fontWeight: FontWeight.bold),
          labelButtonBigDisabled: TextStyle(
              fontSize: 16,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          labelButtonSmall: TextStyle(
              fontSize: 14,
              color: colorTheme.inverseText,
              fontWeight: FontWeight.bold),
          labelButtonSmallDisabled: TextStyle(
              fontSize: 14,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          bodyBig: TextStyle(fontSize: 18, color: colorTheme.inverseText),
          bodyNormal: TextStyle(fontSize: 16, color: colorTheme.inverseText),
          bodySmall: TextStyle(fontSize: 14, color: colorTheme.inverseText),
          bodyUltraSmall:
              TextStyle(fontSize: 12, color: colorTheme.inverseText),
          infoBodySubHeader: TextStyle(
              fontSize: 14,
              color: colorTheme.inverseText,
              fontWeight: FontWeight.w600),
        ),
        accentTextTheme: AppTextTheme(
          titleHuge:
              TextStyle(fontSize: 40, color: colorTheme.accent, height: 1.2),
          titleBig:
              TextStyle(fontSize: 30, color: colorTheme.accent, height: 1.2),
          titleNormal: TextStyle(fontSize: 24, color: colorTheme.accent),
          titleSmall: TextStyle(fontSize: 18, color: colorTheme.accent),
          titleListItem: TextStyle(
              fontSize: 18,
              color: colorTheme.accent,
              fontWeight: FontWeight.bold),
          labelButtonBig: TextStyle(
              fontSize: 16,
              color: colorTheme.accent,
              fontWeight: FontWeight.bold),
          labelButtonBigDisabled: TextStyle(
              fontSize: 16,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          labelButtonSmall: TextStyle(
              fontSize: 14,
              color: colorTheme.accent,
              fontWeight: FontWeight.bold),
          labelButtonSmallDisabled: TextStyle(
              fontSize: 14,
              color: colorTheme.disabledButtonText,
              fontWeight: FontWeight.bold),
          bodyBig: TextStyle(fontSize: 18, color: colorTheme.accent),
          bodyNormal: TextStyle(fontSize: 16, color: colorTheme.accent),
          bodySmall: TextStyle(fontSize: 14, color: colorTheme.accent),
          bodyUltraSmall: TextStyle(fontSize: 12, color: colorTheme.accent),
          infoBodySubHeader: TextStyle(
              fontSize: 14,
              color: colorTheme.accent,
              fontWeight: FontWeight.w600),
        ),
        exceptionsTextTheme: const AppTextThemeExceptions(),
      );

  const AppTheme._({
    required this.coreTextTheme,
    required this.inverseCoreTextTheme,
    required this.accentTextTheme,
    required this.exceptionsTextTheme,
    required this.colorsTheme,
  });

  static AppTheme of(BuildContext context,
      {bool forceDark = false, bool forceLight = false}) {
    if (forceDark) return instanceDark;
    if (forceLight) return instanceLight;

    /*final theme = FlavorConfig.instance.themeMode;
    if (theme == ThemeMode.dark) {
      return instanceDark;
    } else if (theme == ThemeMode.light) {
      return instanceLight;
    }*/
    final brightness = MediaQuery.of(context).platformBrightness;

    if (brightness == Brightness.dark) return instanceDark;

    return instanceLight;
  }
}
