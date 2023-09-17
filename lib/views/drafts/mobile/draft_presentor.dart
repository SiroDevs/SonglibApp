import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../navigator/main_navigator.dart';
import '../../../theme/theme_colors.dart';
import '../../../viewmodels/drafts/draft_presentor_vm.dart';
import '../../../widgets/action/fab_widget.dart';
import '../../../widgets/general/present_on_mobile.dart';
import '../../../widgets/progress/circular_progress.dart';

/// Screen to present a draft in slide format
class DraftPresentor extends StatefulWidget {
  const DraftPresentor({Key? key}) : super(key: key);

  @override
  DraftPresentorState createState() => DraftPresentorState();
}

@visibleForTesting
class DraftPresentorState extends State<DraftPresentor>
    implements DraftPresentorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DraftPresentorVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<DraftPresentorVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;
          vm.size = size;
          vm.tr = AppLocalizations.of(context)!;

          var appBarWidget = AppBar(
            title: Text(vm.draftTitle),
            actions: <Widget>[
              InkWell(
                onTap: () => vm.navigator.goToDraftEditor(true),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.edit),
                ),
              ),
              InkWell(
                onTap: () async {
                  await vm.confirmDelete(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.delete),
                ),
              ),
            ],
          );

          return Scaffold(
            appBar: appBarWidget,
            body: Container(
              height: size!.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.orange,
                    ThemeColors.accent,
                    ThemeColors.primary,
                    Colors.black,
                  ],
                ),
              ),
              child: SizedBox(
                child: vm.isBusy
                    ? const CircularProgress()
                    : vm.widgetTabs.isNotEmpty
                        ? PresentOnMobile(
                            index: vm.curSlide,
                            tabsElevation: 5,
                            songbook: '',
                            tabs: vm.widgetTabs,
                            contents: vm.widgetContent,
                            tabsWidth: size!.height * 0.08156,
                            indicatorWidth: size!.height * 0.08156,
                            contentScrollAxis: vm.slideHorizontal
                                ? Axis.horizontal
                                : Axis.vertical,
                          )
                        : const SizedBox.shrink(),
              ),
            ),
            floatingActionButton: ExpandableFab(
              distance: 112.0,
              children: [
                FloatingActionButton(
                  heroTag: 'share_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: () {
                    Share.share(
                      '${vm.draftTitle}\n${vm.draftBook}\n\n${vm.draftContent}',
                      subject: 'Share Draft',
                    );
                  },
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'copy_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: vm.copyDraft,
                  child: const Icon(Icons.copy, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'edit_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: () => vm.navigator.goToDraftEditor(true),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void goToDraftEditor(bool notEmpty) =>
      MainNavigator.of(context).goToDraftEditor(notEmpty);
}
