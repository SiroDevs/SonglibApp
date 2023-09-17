import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/global_vm.dart';
import '../../viewmodels/manage/settings_vm.dart';

/// Settings screen for user to change app options
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

@visibleForTesting
class SettingsScreenState extends State<SettingsScreen>
    implements SettingsNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    //String theme = "System Default";
    String wakeLock = 'Disabled', slideDirection = 'Vertical (Up, Down)';
    return ChangeNotifierProvider<SettingsVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<SettingsVm>(
        builder: (ctx, vm, child) {
          //vm.context = ctx;
          //vm.tr = AppLocalizations.of(ctx)!;
          var mainView = Consumer<AppVm>(builder: (context, vm, child) {
            if (vm.wakeLockStatus) {
              wakeLock = 'Enabled';
            } else {
              wakeLock = 'Disabled';
            }
            if (vm.slideHorizontal) {
              slideDirection = 'Horizontal (Left, Right)';
            } else {
              slideDirection = 'Vertical (Up, Down)';
            }
            /*if (vm.themeMode == ThemeMode.light) {
              theme = tr.themeLight;
            } else if (vm.themeMode == ThemeMode.dark) {
              theme = tr.themeDark;
            }*/

            var songbooks = Card(
              child: ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Songbooks Management'),
                subtitle: const Text('Reselect your songbooks afresh'),
                onTap: () => goToSelection(),
              ),
            );
            var screenAwake = Card(
              child: ExpansionTile(
                leading: const Icon(Icons.display_settings),
                title: const Text('Keep Screen On in Song View'),
                subtitle: Text('Status: $wakeLock'),
                children: [
                  /*SelectorItem(
                    title: 'Enable',
                    onClick: () => vm.updateWakeLockStatus(true),
                    selected: vm.wakeLockStatus == true,
                  ),
                  SelectorItem(
                    title: 'Disable',
                    onClick: () => vm.updateWakeLockStatus(false),
                    selected: vm.wakeLockStatus == false,
                  ),*/
                ],
              ),
            );
            var sliderDirection = Card(
              child: ExpansionTile(
                leading: const Icon(Icons.display_settings),
                title: const Text('Song Slides Direction'),
                subtitle: Text('Direction: $slideDirection'),
                children: [
                  /*SelectorItem(
                    title: 'Vertical (Up, Down)',
                    onClick: () => vm.updateSlideHorizontal(false),
                    selected: vm.slideHorizontal == false,
                  ),
                  SelectorItem(
                    title: 'Horizontal (Left, Right)',
                    onClick: () => vm.updateSlideHorizontal(true),
                    selected: vm.slideHorizontal == true,
                  ),*/
                ],
              ),
            );
            /*var themes = Card(
              child: ExpansionTile(
                leading: const Icon(Icons.display_settings),
                title: const Text('Theme Mode'),
                subtitle: Text('Theme: $theme'),
                children: [
                  /*SelectorItem(
                    title: 'Default',
                    onClick: () => vm.updateThemeMode(ThemeMode.system),
                    selected: vm.themeMode == ThemeMode.system,
                  ),
                  SelectorItem(
                    title: 'Light',
                    onClick: () => vm.updateThemeMode(ThemeMode.light),
                    selected: vm.themeMode == ThemeMode.light,
                  ),
                  SelectorItem(
                    title: 'Dark',
                    onClick: () => vm.updateThemeMode(ThemeMode.dark),
                    selected: vm.themeMode == ThemeMode.dark,
                  ),*/
                ],
              ),
            );*/

            final dateValue = DateTime.parse(vm.timeInstalled);
            final String lastInstalled = timeago.format(dateValue);
            var timeInstalled = Card(
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Time Installed'),
                subtitle: Text(lastInstalled),
              ),
            );

            return ListView(
              padding: const EdgeInsets.all(5),
              children: [
                songbooks,
                if (isMobile) screenAwake,
                if (isMobile) sliderDirection,
                //themes,
                timeInstalled,
              ],
            );
          });
          return isDesktop
              ? Scaffold(
                  backgroundColor: ThemeColors.backgroundGrey,
                  body: mainView,
                )
              : Scaffold(
                  backgroundColor: ThemeColors.backgroundGrey,
                  appBar: AppBar(
                    title: Text(tr.settingsTitle),
                  ),
                  body: mainView,
                );
        },
      ),
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  @override
  void goToSelection() => MainNavigator.of(context).goToSelection();
}
