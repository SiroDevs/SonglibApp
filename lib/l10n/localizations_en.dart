// The translations for English (`en`).
class LocalizationsEn {
  LocalizationsEn._();

  static String get login => 'Login';

  static String get justFillLoginForm => 'Just fill in some text. There is no validator for the login';

  static String get email => 'Email';

  static String get password => 'Password';

  static String get todoTitle => 'Todos';

  static String get settingsTitle => 'Settings';

  static String get animationsTitle => 'Animations';

  static String get slowAnimations => 'Slow animations';

  static String get selectPlatform => 'Select Platform';

  static String currentPlatform(String platform) {
    return 'Current platfrom: $platform';
  }

  static String get selectLanguage => 'Select Language';

  static String currentLanguage(String language) {
    return 'Current language: $language';
  }

  static String get selectTheme => 'Select Theme';

  static String currentTheme(String theme) {
    return 'Current theme: $theme';
  }

  static String get licencesTitle => 'Licences';

  static String get viewLicences => 'View Licences';

  static String get systemDefault => 'System Default';

  static String get darkLabel => 'Dark';

  static String get lightLabel => 'Light';

  static String get languageTitle => 'Language';

  static String get themeTitle => 'Theme';

  static String get databaseTitle => 'Database';

  static String get viewDatabase => 'View Database';

  static String get errorBadRequest => 'Bad request error';

  static String get errorDuringDev => 'You coded something wrong';

  static String get errorForbidden => 'Forbidden error';

  static String get errorGeneral => 'Something went wrong';

  static String errorGeneralWithCode(String code) {
    return 'Something went wrong (code: $code)';
  }

  static String get errorInternalServer => 'Internal server error';

  static String get errorNoNetwork => 'No internet connection available';

  static String get errorUnauthorized => 'Unauthorized error';

  static String get cancelLabel => 'Cancel';

  static String get deleteLabel => 'Delete';

  static String get noLabel => 'No';

  static String get okLabel => 'Ok';

  static String get saveLabel => 'Save';

  static String get yesLabel => 'Yes';

  static String get todoAddInputHint => 'Enter your Todo';

  static String get todoAddTitle => 'Add todo';

  static String get todoEmptyState => 'No data added to your database. Fetch some todos with an api call (download icon) or add one yourself by clicking the add icon.';
}
