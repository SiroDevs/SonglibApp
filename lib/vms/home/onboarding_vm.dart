import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../repository/shared_prefs/local_storage.dart';
import '../../utils/constants/pref_constants.dart';

@injectable
class OnboardingVm with ChangeNotifierEx {
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
