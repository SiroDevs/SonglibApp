import 'package:flutter/material.dart';

import '../navigator/main_navigation.dart';
import '../views/drafts/draft_editor.dart';
import '../views/drafts/mobile/draft_presentor.dart';
import '../views/drafts/pc/draft_presentor_pc.dart';
import '../views/home/home_screen.dart';
import '../views/info/donation_screen.dart';
import '../views/info/helpdesk_screen.dart';
import '../views/info/onboarding_screen.dart';
import '../views/lists/list_view_screen.dart';
import '../views/selection/selection_screen.dart';
import '../views/songs/mobile/song_editor.dart';
import '../views/songs/mobile/song_presentor.dart';
import '../views/songs/pc/song_editor_pc.dart';
import '../views/songs/pc/song_presentor_pc.dart';
import '../views/splash_screen.dart';
import '../views/user/signin_screen.dart';
import '../views/user/signup_screen.dart';
import '../views/user/user_screen.dart';
import '../widgets/general/text_scale_factor.dart';
import 'route_names.dart';

class MainNavigator extends StatefulWidget {
  final Widget? child;

  const MainNavigator({
    this.child,
    Key? key,
  }) : super(key: key);

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
            'widget that is a descendant of a MainNavigator widget.');
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

  static String get initialRoute => RouteNames.splash;

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
    final Map<String, WidgetBuilder> routes = {
      '': (context) => const SplashScreen(),
      RouteNames.splash: (context) => const SplashScreen(),
      RouteNames.selection: (context) => const SelectionScreen(),
      RouteNames.onboarding: (context) => const OnboardingScreen(),
      RouteNames.home: (context) => const HomeScreen(),
      RouteNames.presentSong: (context) => const SongPresentor(),
      RouteNames.presentSongPc: (context) => const SongPresentorPc(),
      RouteNames.presentDraft: (context) => const DraftPresentor(),
      RouteNames.presentDraftPc: (context) => const DraftPresentorPc(),
      RouteNames.editSong: (context) => const SongEditor(),
      RouteNames.editSongPc: (context) => const SongEditorPc(),
      RouteNames.editDraft: (context) => const DraftEditor(),
      RouteNames.editDraftPc: (context) => const DraftEditor(),
      RouteNames.list: (context) => const ListViewScreen(),
      RouteNames.helpdesk: (context) => const HelpDeskScreen(),
      RouteNames.donation: (context) => const DonationScreen(),
      RouteNames.user: (context) => const UserScreen(),
      RouteNames.signin: (context) => const SigninScreen(),
      RouteNames.signup: (context) => const SignupScreen(),
    };

    defaultRoute(context) => const SplashScreen();

    WidgetBuilder? getRouteBuilder(String routeName) {
      if (routes.containsKey(routeName)) {
        return routes[routeName];
      } else {
        return defaultRoute;
      }
    }

    MaterialPageRoute<void> createMaterialPageRoute(
        WidgetBuilder builder, RouteSettings settings) {
      return MaterialPageRoute<void>(
        builder: builder,
        settings: settings,
      );
    }

    WidgetBuilder? routeBuilder = getRouteBuilder(strippedPath!);
    if (routeBuilder != null) {
      return createMaterialPageRoute(routeBuilder, settings);
    } else {
      return null;
    }
  }

  @override
  void goToSplash() => navigator.pushReplacementNamed(RouteNames.splash);

  @override
  void goToSelection() => navigator.pushReplacementNamed(RouteNames.selection);

  @override
  void goToOnboarding() =>
      navigator.pushReplacementNamed(RouteNames.onboarding);

  @override
  void goToHome() =>
      navigator.pushNamedAndRemoveUntil(RouteNames.home, (route) => false);

  @override
  void goToSongPresentor() => navigator.pushNamed(RouteNames.presentSong);

  @override
  void goToSongPresentorPc() => navigator.pushNamed(RouteNames.presentSongPc);

  @override
  void goToDraftPresentor() => navigator.pushNamed(RouteNames.presentDraft);

  @override
  void goToDraftPresentorPc() => navigator.pushNamed(RouteNames.presentDraftPc);

  @override
  void goToSongEditor() => navigator.pushNamed(RouteNames.editDraftPc);

  @override
  void goToSongEditorPc() => navigator.pushNamed(RouteNames.editDraftPc);

  @override
  void goToDraftEditor(bool notEmpty) => navigator.pushNamed(
        RouteNames.editDraft,
        arguments: {'not_empty': notEmpty},
      );

  @override
  void goToListView() => navigator.pushNamed(RouteNames.list);

  @override
  void goToSettings() => navigator.pushNamed(RouteNames.settings);

  @override
  void goToHelpDesk() => navigator.pushNamed(RouteNames.helpdesk);

  @override
  void goToDonation() => navigator.pushNamed(RouteNames.donation);

  @override
  void goToUser() => navigator.pushNamed(RouteNames.user);

  @override
  void goToSignin() => navigator.pushNamed(RouteNames.signin);

  @override
  void goToSignup() => navigator.pushNamed(RouteNames.signup);

  @override
  void goBack<T>({T? result}) => navigator.pop(result);

  @override
  void showCustomDialog<T>({required WidgetBuilder builder}) => showDialog<T>(
      context: _navigationKey.currentContext!,
      builder: builder,
      useRootNavigator: true);
}
