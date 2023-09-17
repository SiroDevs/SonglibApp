import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/home/info_vm.dart';

/// Help desk screen
class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({Key? key}) : super(key: key);

  @override
  HelpDeskScreenState createState() => HelpDeskScreenState();
}

@visibleForTesting
class HelpDeskScreenState extends State<HelpDeskScreen>
    implements InfoNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    return ChangeNotifierProvider<InfoVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<InfoVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;

          Card support = Card(
            child: ExpansionTile(
              // Display more ways to support the project
              leading: const Icon(Icons.display_settings),
              title: const Text('Support SongLib'),
              subtitle: const Text('Tap for more actions'),
              children: [
                // Display context menu to donate towards the project
                ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text('Donate for the Project'),
                  subtitle:
                      const Text('Give Once, Weekly, Monthly or Quartely'),
                  onTap: () => goToDonation(),
                ),
                // Display context menu to buy merchandise
                ListTile(
                  leading: const Icon(Icons.shopping_basket),
                  title: const Text('Buy our Merchandise'),
                  subtitle:
                      const Text('Order our branded T-Shirts (Kenya Only)'),
                  onTap: () => vm.goToMerchandise(),
                ),
              ],
            ),
          );
          // Display context menu to call, sms, whatsapp or telegram
          Card telegram = Card(
            child: ExpansionTile(
              leading: const Icon(Icons.display_settings),
              title: const Text('Mobile Phone'),
              subtitle: const Text('Tap for more actions'),
              children: [
                // Open phone dialer and paste the number
                ListTile(
                  leading: const Icon(Icons.call),
                  title: const Text('Call'),
                  onTap: () => vm.goToCalling(),
                  onLongPress: () => vm.copyText(2),
                ),
                // Open sms
                ListTile(
                  leading: const Icon(Icons.sms),
                  title: const Text('SMS'),
                  onTap: () => vm.goToSms(),
                ),
                // Open whatsapp
                ListTile(
                  leading: const Icon(
                      IconData(0xf05a6, fontFamily: 'MaterialIcons')),
                  title: const Text('WhatsApp'),
                  onTap: () => vm.goToWhatsapp(),
                ),

                /*ListTile(
                leading: const Icon(Icons.telegram),
                title: const Text('TeleGram'),
                onTap: () => vm.goToTelegram(),
              ),*/
              ],
            ),
          );
          var mainView = ListView(
            padding: const EdgeInsets.all(5),
            children: [
              if (vm.dateDiff > 2) support,
              Card(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('How it works'),
                  subtitle:
                      const Text('Revisit the onboarding screen once again'),
                  onTap: () => vm.goToHowItWorks(),
                ),
              ),
              // Redirect to playstore
              Card(
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Rate us & Leave us a Review'),
                  subtitle:
                      const Text('Go to App Store or Long Press to copy link'),
                  onTap: () => vm.goToApptore(),
                  onLongPress: () => vm.copyText(0),
                ),
              ),
              // Redirect to email
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email Address'),
                  subtitle: const Text('futuristicken(at)gmail[.]com'),
                  onTap: () => vm.goToEmail(),
                  onLongPress: () => vm.copyText(1),
                ),
              ),
              telegram,
            ],
          );
          return isDesktop
              ? Scaffold(
                  backgroundColor: ThemeColors.backgroundGrey,
                  body: mainView,
                )
              : Scaffold(
                  backgroundColor: ThemeColors.backgroundGrey,
                  appBar: AppBar(
                    title: Text(tr.helpdeskTitle),
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
