import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../vms/home/info_vm.dart';
import '../../widgets/provider/provider_widget.dart';

// Donation screen
class DonationScreen extends StatefulWidget {
  static const String routeName = RouteNames.donationScreen;

  const DonationScreen({
    Key? key,
  }) : super(key: key);

  @override
  DonationScreenState createState() => DonationScreenState();
}

@visibleForTesting
class DonationScreenState extends State<DonationScreen>
    with BackNavigatorMixin
    implements InfoNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    return ProviderWidget<InfoVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) => Scaffold(
        backgroundColor: ThemeColors.accent,
        appBar: AppBar(
          title: Text(tr.donateTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.all(5),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.money),
                title: const Text('M-Pesa Pochi la Biashara (Kenya)'),
                subtitle: const Text('Tap to copy Number'),
                onTap: () => viewModel.copyNumber(),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Via PayPal (International)'),
                subtitle: const Text('\$5, \$10, \$25 Once or Monthly'),
                onTap: () => viewModel.donateViaPaypal(),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Via Patreon (International)'),
                subtitle: const Text('\$5, \$10, \$25 Monthly'),
                onTap: () => viewModel.donateViaPaetron(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navigates to home screen
  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  // Navigates to onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();

  // Navigates to donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();
}
