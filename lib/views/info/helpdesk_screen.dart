import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../vms/home/info_vm.dart';
import '../../widgets/provider/provider_widget.dart';

/// Help desk screen
class HelpDeskScreen extends StatefulWidget {
  static const String routeName = RouteNames.helpdeskScreen;

  const HelpDeskScreen({
    Key? key,
  }) : super(key: key);

  @override
  HelpDeskScreenState createState() => HelpDeskScreenState();
}

@visibleForTesting
class HelpDeskScreenState extends State<HelpDeskScreen>
    implements InfoNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    return ProviderWidget<InfoVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, vm, child, theme, localization) {
        vm.tr = AppLocalizations.of(context)!;
        Card support = Card(
          child: ExpansionTile(
            leading: const Icon(Icons.display_settings),
            title: const Text('Support SongLib'),
            subtitle: const Text('Tap for more actions'),
            children: [
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Donate for the Project'),
                subtitle: const Text('Give Once, Weekly, Monthly or Quartely'),
                onTap: () => goToDonation(),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_basket),
                title: const Text('Buy our Merchandise'),
                subtitle: const Text('Order our branded T-Shirts (Kenya Only)'),
                onTap: () => vm.goToMerchandise(),
              ),
            ],
          ),
        );
        Card telegram = Card(
          child: ExpansionTile(
            leading: const Icon(Icons.display_settings),
            title: const Text('Mobile Phone'),
            subtitle: const Text('Tap for more actions'),
            children: [
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text('Call'),
                onTap: () => vm.goToCalling(),
                onLongPress: () => vm.copyText(2),
              ),
              ListTile(
                leading: const Icon(Icons.sms),
                title: const Text('SMS'),
                onTap: () => vm.goToSms(),
              ),
              ListTile(
                leading:
                    const Icon(IconData(0xf05a6, fontFamily: 'MaterialIcons')),
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
    );
  }

  // Navigates to Donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();

  // Navigates to Onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();
}
