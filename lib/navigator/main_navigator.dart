import 'package:flutter/material.dart';

import '../navigator/main_navigation.dart';
import '../views/home_screen.dart';
import '../views/splash_screen.dart';
import '../widgets/text_scale_factor.dart';
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
      RouteNames.home: (context) => const HomeScreen(),
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
  void goToHome() =>
      navigator.pushNamedAndRemoveUntil(RouteNames.home, (route) => false);

  @override
  void goBack<T>({T? result}) => navigator.pop(result);

  @override
  void showCustomDialog<T>({required WidgetBuilder builder}) => showDialog<T>(
      context: _navigationKey.currentContext!,
      builder: builder,
      useRootNavigator: true);
}
