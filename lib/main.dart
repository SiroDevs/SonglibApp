import 'dart:developer' as logger show log;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'di/environments.dart';
import 'di/injectable.dart';
import 'navigator/main_navigator.dart';
import 'theme/theme_data.dart';
import 'viewmodels/app_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger.log('Starting app from main.dart');
  await configureDependencies(Environments.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApplication();
    /*return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return ChangeNotifierProvider<AppViewModel>.value(
          value: AppViewModel(snapshot.data!),
          child: const MyApplication(),
        );
      },
    );*/
  }
}

class MyApplication extends StatelessWidget {
  final Widget? home;

  const MyApplication({Key? key})
      : home = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppViewModel>(
      lazy: false,
      create: (_) => GetIt.I()..init(context),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('sw')],
        theme: Provider.of<AppViewModel>(context).isDarkMode
            ? asDarkTheme
            : asLightTheme,
        navigatorKey: MainNavigatorState.navigationKey,
        initialRoute: MainNavigatorState.initialRoute,
        onGenerateRoute: MainNavigatorState.onGenerateRoute,
        navigatorObservers: MainNavigatorState.navigatorObservers,
        builder: home == null
            ? (context, child) => MainNavigator(child: child)
            : null,
        home: home,
      ),
    );
  }
}
