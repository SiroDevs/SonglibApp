import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel with ChangeNotifier {
  //final LocalStorage localStorage;

  //SplashViewModel(this.localStorage);
  bool isLoaded = false, onBoarded = false, notificationsEnabled = false;
  late final SplashNavigator navigator;

  Future<void> init(SplashNavigator screenNavigator) async {
    navigator = screenNavigator;
    await Future.delayed(const Duration(seconds: 3), () {});
    navigator.goToHome();
  }
}

abstract class SplashNavigator {
  void goToHome();
}
