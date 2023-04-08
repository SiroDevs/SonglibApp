import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../util/utilities.dart';
import '../../vm/global_vm.dart';
import '../../vm/manage/settings_vm.dart';
import '../../widget/provider/provider_widget.dart';
import '../../widget/general/selector_item.dart';

/// Settings screen for user to change app options
class SettingsScreen extends StatefulWidget {
  static const String routeName = RouteNames.settingsScreen;

  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

@visibleForTesting
class SettingsScreenState extends State<SettingsScreen>
    with BackNavigatorMixin
    implements SettingsNavigator {
  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    String theme = "System Default";
    String wakeLock = 'Disabled', slideDirection = 'Vertical (Up, Down)';
    return ProviderWidget<SettingsVm>(
      create: () => GetIt.I()..init(this),
      childBuilderWithViewModel: (context, value, _, localization) {
        var mainView = Consumer<GlobalVm>(builder: (context, viewModel, child) {
          if (viewModel.wakeLockStatus) {
            wakeLock = 'Enabled';
          } else {
            wakeLock = 'Disabled';
          }
          if (viewModel.slideHorizontal) {
            slideDirection = 'Horizontal (Left, Right)';
          } else {
            slideDirection = 'Vertical (Up, Down)';
          }
          if (viewModel.themeMode == ThemeMode.light) {
            theme = tr.themeLight;
          } else if (viewModel.themeMode == ThemeMode.dark) {
            theme = tr.themeDark;
          }

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
                SelectorItem(
                  title: 'Enable',
                  onClick: () => viewModel.updateWakeLockStatus(true),
                  selected: viewModel.wakeLockStatus == true,
                ),
                SelectorItem(
                  title: 'Disable',
                  onClick: () => viewModel.updateWakeLockStatus(false),
                  selected: viewModel.wakeLockStatus == false,
                ),
              ],
            ),
          );
          var sliderDirection = Card(
            child: ExpansionTile(
              leading: const Icon(Icons.display_settings),
              title: const Text('Song Slides Direction'),
              subtitle: Text('Direction: $slideDirection'),
              children: [
                SelectorItem(
                  title: 'Vertical (Up, Down)',
                  onClick: () => viewModel.updateSlideHorizontal(false),
                  selected: viewModel.slideHorizontal == false,
                ),
                SelectorItem(
                  title: 'Horizontal (Left, Right)',
                  onClick: () => viewModel.updateSlideHorizontal(true),
                  selected: viewModel.slideHorizontal == true,
                ),
              ],
            ),
          );
          var themes = Card(
            child: ExpansionTile(
              leading: const Icon(Icons.display_settings),
              title: const Text('Theme Mode'),
              subtitle: Text('Theme: $theme'),
              children: [
                SelectorItem(
                  title: 'Default',
                  onClick: () => viewModel.updateThemeMode(ThemeMode.system),
                  selected: viewModel.themeMode == ThemeMode.system,
                ),
                SelectorItem(
                  title: 'Light',
                  onClick: () => viewModel.updateThemeMode(ThemeMode.light),
                  selected: viewModel.themeMode == ThemeMode.light,
                ),
                SelectorItem(
                  title: 'Dark',
                  onClick: () => viewModel.updateThemeMode(ThemeMode.dark),
                  selected: viewModel.themeMode == ThemeMode.dark,
                ),
              ],
            ),
          );
          return ListView(
            padding: const EdgeInsets.all(5),
            children: [
              songbooks,
              if (isMobile) screenAwake,
              if (isMobile) sliderDirection,
              //themes,
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
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  @override
  void goToSelection() => MainNavigator.of(context).goToSelection();
}
