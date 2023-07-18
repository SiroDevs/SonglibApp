import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../vms/user/user_vm.dart';
import '../../widgets/provider/provider_widget.dart';

/// Help desk screen
class UserScreen extends StatefulWidget {
  static const String routeName = RouteNames.userScreen;

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
    var tr = AppLocalizations.of(context)!;
    return ProviderWidget<UserVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, vm, child, theme, localization) {
        vm.tr = AppLocalizations.of(context)!;
        
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
    );
  }

  // Navigates to Donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();

  // Navigates to Onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();
}
