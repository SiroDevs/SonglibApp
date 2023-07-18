import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../vms/selection/selection_vm.dart';
import '../../widgets/action/buttons.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/provider/provider_widget.dart';

/// Song book selection screen
class SelectionScreen extends StatefulWidget {
  static const String routeName = 'selection';

  const SelectionScreen({Key? key}) : super(key: key);

  @override
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen>
    implements SelectionNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    bool isTabletOrIpad = size!.shortestSide > 550;
    return ProviderWidget<SelectionVm>(
      create: () => GetIt.I()..init(this),
      childBuilderWithViewModel: (context, vm, theme, localization) {
        vm.tr = AppLocalizations.of(context)!;
        var topContainer = AppBar(
          title: Text(
            vm.isLoading ? tr.booksTitleLoading : tr.booksTitle,
          ),
          actions: <Widget>[
            vm.isLoading
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: vm.fetchBooks,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.refresh),
                    ),
                  ),
            vm.isLoading
                ? const SizedBox.shrink()
                : vm.hasError
                    ? const SizedBox.shrink()
                    : IconTextBtn(
                        onPressed: () => areYouDoneDialog(context, vm),
                        title: tr.proceed,
                      ),
          ],
        );

        var bigScreenLayout = LayoutBuilder(
          builder: (context, dimens) {
            int axisCount = (dimens.maxWidth / 450).round();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: axisCount,
                childAspectRatio: 4,
              ),
              itemCount: vm.books!.length,
              itemBuilder: (context, index) => BookItem(
                book: vm.books![index],
                selected: vm.listedBooks[index]!.isSelected,
                onPressed: () => vm.onBookSelected(index),
              ),
            );
          },
        );
        var smallScreenLayout = ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: vm.books!.length,
          itemBuilder: (context, index) => BookItem(
            book: vm.books![index],
            selected: vm.listedBooks[index]!.isSelected,
            onPressed: () => vm.onBookSelected(index),
          ),
        );

        return Scaffold(
          appBar: topContainer,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  vm.isLoading
                      ? const CircularProgress()
                      : vm.books!.isNotEmpty
                          ? isDesktop || isMobile && isTabletOrIpad
                              ? bigScreenLayout
                              : smallScreenLayout
                          : const SizedBox.shrink(),
                  vm.hasError
                      ? NoDataToShow(
                          title: vm.errorTitle,
                          description: vm.errorBody,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          floatingActionButton: vm.isLoading
              ? const SizedBox.shrink()
              : vm.hasError
                  ? const SizedBox.shrink()
                  : FloatingActionButton(
                      backgroundColor: ThemeColors.primary,
                      onPressed: () => areYouDoneDialog(context, vm),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
        );
      },
    );
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
      await FlutterPlatformAlert.showCustomAlert(
        windowTitle: tr.noSelection,
        text: tr.noSelectionBody,
        iconStyle: IconStyle.warning,
        neutralButtonTitle: tr.okay,
      );
    }
  }

  @override
  void goToProgress() => MainNavigator.of(context).goToProgress();
}
