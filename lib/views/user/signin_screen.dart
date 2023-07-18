import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../vms/user/signin_vm.dart';
import '../../widgets/action/primary_btn.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/provider/provider_widget.dart';

/// Signin screen
class SigninScreen extends StatefulWidget {
  static const String routeName = RouteNames.signinScreen;

  const SigninScreen({
    Key? key,
  }) : super(key: key);

  @override
  SigninScreenState createState() => SigninScreenState();
}

@visibleForTesting
class SigninScreenState extends State<SigninScreen>
    with BackNavigatorMixin
    implements SigninNavigator {

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SigninVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (ctx, vm, child, theme, localization) {
        vm.context = ctx;
        vm.tr = AppLocalizations.of(ctx)!;
        var signinForm = ListView(
          padding: const EdgeInsets.all(5),
          children: [
            FormInput(
              iLabel: 'Username',
              iController: vm.usernameController!,
              prefix: const Icon(Icons.person, color: ThemeColors.primary),
            ),
            PasswordInput(
              iLabel: 'Password',
              iController: vm.passwordController!,
            ),
            PrimaryTextBtn(
              'Sign In',
              onPressed: () => vm.loginUser(),
              bgColor: ThemeColors.primary,
              foreColor: Colors.white,
              hoverColor: Colors.red,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text("Don't have an account?"),
            ),
            PrimaryTextBtn(
              'Sign Up',
              onPressed: () => MainNavigator.of(ctx).goToSignup(),
              bgColor: ThemeColors.primary,
              foreColor: Colors.white,
              hoverColor: Colors.red,
            ),
          ],
        );
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign In to Proceed'),
            actions: <Widget>[
              InkWell(
                onTap: () => vm.hintsDialog(ctx),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.info),
                ),
              ),
            ],
          ),
          body: vm.isBusy ? const CircularProgress() : signinForm,
        );
      },
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();
}
