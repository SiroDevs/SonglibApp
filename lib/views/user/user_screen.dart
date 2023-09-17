import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../viewmodels/user/user_vm.dart';

/// Help desk screen
class UserScreen extends StatefulWidget {
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  UserScreenState createState() => UserScreenState();
}

@visibleForTesting
class UserScreenState extends State<UserScreen> implements UserNavigator {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<UserVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;

          var mainView = ListView(
            padding: const EdgeInsets.all(5),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sign Out'),
                  onTap: () => vm.goToEmail(),
                  onLongPress: () => vm.copyText(1),
                ),
              ),
            ],
          );
          return Scaffold(
            backgroundColor: ThemeColors.backgroundGrey,
            appBar: AppBar(
              title: const Text('App User'),
            ),
            body: mainView,
          );
        },
      ),
    );
  }

  // Navigates to Donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();

  // Navigates to Onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();
}
