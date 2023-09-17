import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../viewmodels/home/info_vm.dart';

/// Donation screen
class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  DonationScreenState createState() => DonationScreenState();
}

@visibleForTesting
class DonationScreenState extends State<DonationScreen>
    implements InfoNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    return ChangeNotifierProvider<InfoVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<InfoVm>(
        builder: (ctx, vm, child) => Scaffold(
          backgroundColor: ThemeColors.accent,
          appBar: AppBar(
            title: Text(tr.donateTitle),
          ),
          body: ListView(
            padding: const EdgeInsets.all(5),
            children: [
              // Implement mpesa number for donation
              Card(
                child: ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text('M-Pesa Pochi la Biashara (Kenya)'),
                  subtitle: const Text('Tap to copy Number'),
                  onTap: () => vm.copyNumber(),
                ),
              ),
              // Implement paypal for donation
              Card(
                child: ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text('Via PayPal (International)'),
                  subtitle: const Text('\$5, \$10, \$25 Once or Monthly'),
                  onTap: () => vm.donateViaPaypal(),
                ),
              ),
              // Implement patreon for donation
              Card(
                child: ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text('Via Patreon (International)'),
                  subtitle: const Text('\$5, \$10, \$25 Monthly'),
                  onTap: () => vm.donateViaPaetron(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigates to onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();

  // Navigates to donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();
}
