import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';

@injectable
class SettingsVm with ChangeNotifier {
  late final SettingsNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  SettingsVm(this.dbRepo, this.localStorage);

  Future<void> init(SettingsNavigator screenNavigator) async {
    navigator = screenNavigator;
  }
}

abstract class SettingsNavigator  {
  void goToHome();

  void goToSelection();
}
