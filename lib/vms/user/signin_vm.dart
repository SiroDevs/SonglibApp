import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../navigator/mixin/back_navigator.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../utils/constants/pref_constants.dart';
import '../../widgets/general/toast.dart';

@injectable
class SigninVm with ChangeNotifierEx {
  final LocalStorage localStorage;
  late final SigninNavigator navigator;

  bool isBusy = false, shownAccountHints = false;
  SigninVm(this.localStorage);

  BuildContext? context;
  AppLocalizations? tr;
  TextEditingController? usernameController, passwordController;

  Future<void> init(SigninNavigator screenNavigator) async {
    navigator = screenNavigator;
    shownAccountHints =
        localStorage.getPrefBool(PrefConstants.accountsHintsKey);
    usernameController = TextEditingController(
      text: localStorage.getPrefString(PrefConstants.userName),
    );
    passwordController = TextEditingController(
      text: localStorage.getPrefString(PrefConstants.passWord),
    );

    if (shownAccountHints) hintsDialog(context!);
  }

  Future<void> loginUser() async {
    isBusy = true;
    notifyListeners();

    final user = ParseUser(
      usernameController!.text.trim(),
      passwordController!.text.trim(),
      null,
    );

    var response = await user.login();

    localStorage.setPrefString(
        PrefConstants.userName, usernameController!.text.trim());
    localStorage.setPrefString(
        PrefConstants.passWord, passwordController!.text.trim());

    isBusy = false;
    notifyListeners();

    if (response.success) {
      localStorage.setPrefBool(PrefConstants.isLoggedIn, true);
      showToast(text: 'Sign in was successful', state: ToastStates.success);
      navigator.goToHome();
    } else {
      showToast(text: response.error!.message, state: ToastStates.error);
    }
  }

  Future<void> hintsDialog(BuildContext context) async {
    var result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'So why sign in?',
      text:
          'We are giving you the ability to edit songs on this app on behalf of other users. Your changes will be synced across other users once they are approved by our trusted moderators.\n\nTo do that, a user account is needed. That is why we are asking you either sign in or sign up.',
      iconStyle: IconStyle.information,
      negativeButtonTitle: tr!.cancel,
      positiveButtonTitle: tr!.okay,
    );
    if (result == CustomButton.negativeButton) {
      navigator.goBack<void>();
    } else if (result == CustomButton.positiveButton) {
      localStorage.setPrefBool(PrefConstants.accountsHintsKey, true);
    }
  }
}

abstract class SigninNavigator implements BackNavigator {
  void goToHome();
}
