import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../views/drafts/draft_editor.dart';
import '../views/drafts/mobile/draft_presentor.dart';
import '../views/drafts/pc/draft_presentor_pc.dart';
import '../views/home/home_screen.dart';
import '../views/home/home_screen_web.dart';
import '../views/info/donation_screen.dart';
import '../views/info/helpdesk_screen.dart';
import '../views/lists/list_view_screen.dart';
import '../views/manage/settings_screen.dart';
import '../views/info/onboarding_screen.dart';
import '../views/selection/progress_screen.dart';
import '../views/selection/selection_screen.dart';
import '../views/songs/mobile/song_editor.dart';
import '../views/songs/pc/song_editor_pc.dart';
import '../views/songs/pc/song_presentor_pc.dart';
import '../views/songs/mobile/song_presentor.dart';
import '../views/splash_screen.dart';
import '../utils/env/flavor_config.dart';
import '../views/user/signin_screen.dart';
import '../views/user/signup_screen.dart';
import '../views/user/user_screen.dart';
import '../widgets/general/text_scale_factor.dart';
import 'main_navigation.dart';

class MainNavigator extends StatefulWidget {
  final Widget? child;

  const MainNavigator({this.child, Key? key}) : super(key: key);

  @override
  MainNavigatorState createState() => MainNavigatorState();

  static MainNavigationMixin of(BuildContext context,
      {bool rootNavigator = false}) {
    final navigator = rootNavigator
        ? context.findRootAncestorStateOfType<MainNavigationMixin>()
        : context.findAncestorStateOfType<MainNavigationMixin>();
    assert(() {
      if (navigator == null) {
        throw FlutterError(
            'MainNavigation operation requested with a context that does not include a MainNavigation.\n'
            'The context used to push or pop routes from the MainNavigation must be that of a '
            'widgets that is a descendant of a MainNavigator widget.');
      }
      return true;
    }());
    return navigator!;
  }
}

class MainNavigatorState extends State<MainNavigator> with MainNavigationMixin {
  static final GlobalKey<NavigatorState> _navigationKey =
      GlobalKey<NavigatorState>();
  static final List<NavigatorObserver> _navigatorObservers = [];

  static String get initialRoute =>
      FlavorConfig.isInTest() ? 'test_route' : SplashScreen.routeName;

  static GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  static List<NavigatorObserver> get navigatorObservers => _navigatorObservers;

  NavigatorState get navigator => _navigationKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return TextScaleFactor(
      child: widget.child ?? const SizedBox.shrink(),
    );
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final strippedPath = settings.name?.replaceFirst('/', '');
    //final args = settings.arguments as Map;
    //print(args[0]);

    switch (strippedPath) {
      case '':
      case SplashScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case SelectionScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SelectionScreen(),
          settings: settings,
        );
      case OnboardingScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const OnboardingScreen(),
          settings: settings,
        );
      case ProgressScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const ProgressScreen(),
          settings: settings,
        );
      case HomeScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) =>
              kIsWeb ? const HomeScreenWeb() : const HomeScreen(),
          settings: settings,
        );
      case SongPresentor.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SongPresentor(),
          settings: settings,
        );
      case SongPresentorPc.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SongPresentorPc(),
          settings: settings,
        );

      case DraftPresentor.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const DraftPresentor(),
          settings: settings,
        );
      case DraftPresentorPc.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const DraftPresentorPc(),
          settings: settings,
        );

      case SongEditor.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SongEditor(),
          settings: settings,
        );
      case SongEditorPc.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SongEditorPc(),
          settings: settings,
        );

      case DraftEditor.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const DraftEditor(),
          settings: settings,
        );

      case ListViewScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const ListViewScreen(),
          settings: settings,
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SettingsScreen(),
          settings: settings,
        );
      case HelpDeskScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const HelpDeskScreen(),
          settings: settings,
        );
      case DonationScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const DonationScreen(),
          settings: settings,
        );

      case UserScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const UserScreen(),
          settings: settings,
        );
      case SigninScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SigninScreen(),
          settings: settings,
        );
      case SignupScreen.routeName:
        return MaterialPageRoute<void>(
          builder: (context) => const SignupScreen(),
          settings: settings,
        );

      case 'test_route':
        if (!FlavorConfig.isInTest()) return null;
        return MaterialPageRoute<void>(
          builder: (context) => Container(color: Colors.grey),
          settings: settings,
        );
      default:
        return null;
    }
  }

  @override
  void goToSplash() => navigator.pushReplacementNamed(SplashScreen.routeName);

  @override
  void goToSelection() =>
      navigator.pushReplacementNamed(SelectionScreen.routeName);

  @override
  void goToProgress() =>
      navigator.pushReplacementNamed(ProgressScreen.routeName);

  @override
  void goToOnboarding() =>
      navigator.pushReplacementNamed(OnboardingScreen.routeName);

  @override
  void goToHome() =>
      navigator.pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);

  @override
  void goToSongPresentor() => navigator.pushNamed(SongPresentor.routeName);

  @override
  void goToSongPresentorPc() => navigator.pushNamed(SongPresentorPc.routeName);

  @override
  void goToDraftPresentor() => navigator.pushNamed(DraftPresentor.routeName);

  @override
  void goToDraftPresentorPc() =>
      navigator.pushNamed(DraftPresentorPc.routeName);

  @override
  void goToSongEditor() => navigator.pushNamed(SongEditor.routeName);

  @override
  void goToSongEditorPc() => navigator.pushNamed(SongEditorPc.routeName);

  @override
  void goToDraftEditor(bool notEmpty) => navigator.pushNamed(
        DraftEditor.routeName,
        arguments: {'not_empty': notEmpty},
      );

  @override
  void goToListView() => navigator.pushNamed(ListViewScreen.routeName);

  @override
  void goToSettings() => navigator.pushNamed(SettingsScreen.routeName);

  @override
  void goToHelpDesk() => navigator.pushNamed(HelpDeskScreen.routeName);

  @override
  void goToDonation() => navigator.pushNamed(DonationScreen.routeName);

  @override
  void goToUser() => navigator.pushNamed(UserScreen.routeName);

  @override
  void goToSignin() => navigator.pushNamed(SigninScreen.routeName);

  @override
  void goToSignup() => navigator.pushNamed(SignupScreen.routeName);

  @override
  void closeDialog() => navigator.pop();

  @override
  void goBack<T>({T? result}) => navigator.pop(result);

  @override
  Future<T?> showCustomDialog<T>({required WidgetBuilder builder}) =>
      showDialog<T>(
        context: _navigationKey.currentContext!,
        builder: builder,
        useRootNavigator: true,
        barrierColor: Colors.black,
      );
}
