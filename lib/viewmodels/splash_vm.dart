import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../repository/db_repository.dart';
import '../repository/local_storage.dart';
import '../utils/constants/pref_constants.dart';
import '../utils/utilities.dart';

@injectable
class SplashVm with ChangeNotifier {
  bool isLoaded = false, onBoarded = false, notificationsEnabled = false;
  late final SplashNavigator navigator;
  final DbRepository dbRepo;
  final LocalStorage localStorage;

  SplashVm(this.dbRepo, this.localStorage);

  Future<void> init(SplashNavigator screenNavigator) async {
    navigator = screenNavigator;
    await Future.delayed(const Duration(seconds: 3), () {});

    if (kIsWeb) {
      navigator.goToHome();
    } else {
      isLoaded = localStorage.getPrefBool(PrefConstants.dataLoadedCheckKey);
      onBoarded = localStorage.getPrefBool(PrefConstants.onboardedCheckKey);
      await nextActions();
    }
  }

  Future<void> nextActions() async {
    if (isLoaded) {
      await dbRepo.checkAppDatabase();
      navigator.goToHome();
      /*if (onBoarded) {
        navigator.goToHome();
      } else {
        navigator.goToOnboarding();
      }*/
    } else {
      localStorage.setPrefString(PrefConstants.dateInstalledKey, dateNow());
      navigator.goToSelection();
    }
  }
}

abstract class SplashNavigator {
  void goToHome();
  void goToOnboarding();
  void goToSelection();
}
