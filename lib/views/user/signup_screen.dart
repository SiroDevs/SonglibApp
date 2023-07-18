import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../vms/user/signup_vm.dart';
import '../../widgets/action/primary_btn.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/inputs/password_input.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/provider/provider_widget.dart';

/// Signup screen
class SignupScreen extends StatefulWidget {
  static const String routeName = RouteNames.signupScreen;

  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

@visibleForTesting
class SignupScreenState extends State<SignupScreen>
    with BackNavigatorMixin
    implements SignupNavigator {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SignupVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization: (ctx, vm, child, theme, localization) {
        vm.context = ctx;
        vm.tr = AppLocalizations.of(ctx)!;
        var signupForm = ListView(
          padding: const EdgeInsets.all(5),
          children: [
            FormInput(
              iLabel: 'Username',
              iController: vm.usernameController!,
              prefix: const Icon(Icons.person, color: ThemeColors.primary),
            ),
            FormInput(
              iLabel: 'Email Address',
              iController: vm.emailController!,
              prefix: const Icon(Icons.email, color: ThemeColors.primary),
            ),
            PasswordInput(
              iController: vm.passwordController!,
              iType: TextInputType.phone,
            ),
            PrimaryTextBtn(
              'Sign Up',
              onPressed: () => vm.signupUser(),
              bgColor: ThemeColors.primary,
              foreColor: Colors.white,
              hoverColor: Colors.red,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text("Already have an account?"),
            ),
            PrimaryTextBtn(
              'Sign In',
              onPressed: () => MainNavigator.of(ctx).goToSignin(),
              bgColor: ThemeColors.primary,
              foreColor: Colors.white,
              hoverColor: Colors.red,
            ),
          ],
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Create your Account'),
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
          body: vm.isBusy ? const CircularProgress() : signupForm,
        );
      },
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();
}
