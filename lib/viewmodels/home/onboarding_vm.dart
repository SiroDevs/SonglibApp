import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../repository/local_storage.dart';
import '../../utils/constants/pref_constants.dart';

@injectable
class OnboardingVm with ChangeNotifier {
  late final OnboardingNavigator navigator;
  final LocalStorage localStorage;

  OnboardingVm(this.localStorage);

  Future<void> init(OnboardingNavigator screenNavigator) async {
    navigator = screenNavigator;
  }

  Future<void> finishOnboarding() async {
    localStorage.setPrefBool(PrefConstants.onboardedCheckKey, true);
    navigator.goToHome();
  }
}

abstract class OnboardingNavigator {
  void goToHome();
}
