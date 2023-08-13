import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel with ChangeNotifier {
  //final LocalStorage localStorage;

  //SplashViewModel(this.localStorage);

  Future<void> init(HomeNavigator navigator) async {
    //await _localStorage.checkForNewInstallation();
    //navigator.goToHome();
  }
}

abstract class HomeNavigator {
  //void goToHome();
}
