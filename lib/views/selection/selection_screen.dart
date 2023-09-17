import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/selection/selection_vm.dart';
import '../../widgets/action/buttons.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/progress/advanced/advanced_progress.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/progress/response_feedback.dart';

part 'selection_page.dart';
part 'progress_page.dart';

/// Song book selection screen
class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen>
    implements SelectionNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SelectionVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<SelectionVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;

          return Scaffold(
            body: IndexedStack(
              alignment: Alignment.center,
              index: vm.currentPage,
              children: [
                SelectionPage(vm),
                ProgressPage(vm),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();
}

Future<void> areYouDoneDialog(BuildContext context, SelectionVm vm) async {
  var tr = AppLocalizations.of(context)!;
  if (vm.selectables.isNotEmpty) {
    var result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: tr.doneSelecting,
      text: tr.doneSelectingBody,
      iconStyle: IconStyle.information,
      neutralButtonTitle: tr.cancel,
      positiveButtonTitle: tr.proceed,
    );
    if (result == CustomButton.positiveButton) vm.saveBooks();
  } else {
    await FlutterPlatformAlert.showAlert(
      windowTitle: tr.noSelection,
      text: tr.noSelectionBody,
      iconStyle: IconStyle.warning,
    );
  }
}
