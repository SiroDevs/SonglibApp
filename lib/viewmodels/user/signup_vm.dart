import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:injectable/injectable.dart';

import '../../repository/local_storage.dart';
import '../../utils/constants/pref_constants.dart';

@injectable
class SignupVm with ChangeNotifier {
  final LocalStorage localStorage;
  late final SignupNavigator navigator;

  bool isBusy = false, shownAccountHints = false;
  SignupVm(this.localStorage);

  BuildContext? context;
  AppLocalizations? tr;
  TextEditingController? usernameController,
      emailController,
      passwordController;

  Future<void> init(SignupNavigator screenNavigator) async {
    navigator = screenNavigator;
    shownAccountHints =
        localStorage.getPrefBool(PrefConstants.accountsHintsKey);
    emailController = TextEditingController(
      text: localStorage.getPrefString(PrefConstants.userEmail),
    );
    usernameController = TextEditingController(
      text: localStorage.getPrefString(PrefConstants.userName),
    );
    passwordController = TextEditingController(
      text: localStorage.getPrefString(PrefConstants.passWord),
    );

    if (shownAccountHints) hintsDialog(context!);
  }

  Future<void> signupUser() async {
    isBusy = true;
    notifyListeners();

    /*final user = ParseUser.createUser(
      usernameController!.text.trim(),
      passwordController!.text.trim(),
      emailController!.text.trim(),
    );

    var response = await user.signUp();

    localStorage.setPrefString(
        PrefConstants.userEmail, emailController!.text.trim());
    localStorage.setPrefString(
        PrefConstants.userName, usernameController!.text.trim());
    localStorage.setPrefString(
        PrefConstants.passWord, passwordController!.text.trim());

    isBusy = false;
    notifyListeners();

    if (response.success) {
      localStorage.setPrefBool(PrefConstants.isLoggedIn, true);
      showToast(text: 'Signup was successful', state: ToastStates.success);
      navigator.goToHome();
    } else {
      showToast(text: response.error!.message, state: ToastStates.error);
    }*/
  }

  Future<void> hintsDialog(BuildContext context) async {
    var result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'So why sign up?',
      text:
          'We are giving you the ability to edit songs on this app on behalf of other users. Your changes will be synced across other users once they are approved by our trusted moderators.\n\nTo do that, a user account is needed. That is why we are asking you either sign in or sign up.',
      iconStyle: IconStyle.information,
      negativeButtonTitle: tr!.cancel,
      positiveButtonTitle: tr!.okay,
    );
    if (result == CustomButton.negativeButton) {
      Navigator.pop(context, true);
    } else if (result == CustomButton.positiveButton) {
      localStorage.setPrefBool(PrefConstants.accountsHintsKey, true);
    }
  }
}

abstract class SignupNavigator {
  void goToHome();
}
