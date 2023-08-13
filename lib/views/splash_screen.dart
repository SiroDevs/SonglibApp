import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../navigator/main_navigator.dart';
import '../theme/theme_colors.dart';
import '../utils/constants/app_assets.dart';
import '../utils/constants/app_constants.dart';
import '../viewmodels/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

@visibleForTesting
class SplashScreenState extends State<SplashScreen> implements SplashNavigator {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<SplashViewModel>(
        builder: (ctx, vm, child) {
          var withLoveFromRow = const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'with ',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primary,
                ),
              ),
              Icon(
                Icons.favorite_rounded,
                color: ThemeColors.primaryDark,
              ),
              Text(
                ' from',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primary,
                ),
              ),
            ],
          );

          var appDevelopers = const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Names app developers in splash screen
              Text(
                AppConstants.appCredits1,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryDark,
                ),
              ),
              Text(
                ' & ',
                style: TextStyle(
                  fontSize: 20,
                  color: ThemeColors.primary,
                ),
              ),
              Text(
                AppConstants.appCredits2,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primaryDark,
                ),
              ),
            ],
          );

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  // Shows app icon on splash screen
                  Image.asset(AppAssets.appIcon, height: 200, width: 200),
                  const SizedBox(height: 10),
                  const Text(
                    AppConstants.appName,
                    style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Shows app version on splash screen
                  const Text(
                    AppConstants.appVersion,
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 2,
                      color: ThemeColors.primaryDark,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(
                        color: ThemeColors.primaryDark,
                        thickness: 2,
                        height: 50),
                  ),
                  withLoveFromRow,
                  appDevelopers,
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();
}
