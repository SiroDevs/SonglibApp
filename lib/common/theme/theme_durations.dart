class ThemeDurations {
  ThemeDurations._();

  static Duration get menuBackground {
    return const Duration(seconds: 200);
  }

  static Duration get shortAnimationDuration {
    return const Duration(milliseconds: 200);
  }

  static Duration get mediumAnimationDuration {
    return const Duration(milliseconds: 350);
  }

  static Duration get longAnimationDuration {
    return const Duration(milliseconds: 500);
  }

  static Duration get splashAnimationDuration {
    return const Duration(seconds: 1, milliseconds: 500);
  }

  static Duration get demoNetworkCallDuration {
    return const Duration(milliseconds: 800);
  }
}
