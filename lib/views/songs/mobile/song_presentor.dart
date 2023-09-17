import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../navigator/main_navigator.dart';
import '../../../theme/theme_colors.dart';
import '../../../viewmodels/songs/song_presentor_vm.dart';
import '../../../widgets/action/fab_widget.dart';
import '../../../widgets/general/present_on_mobile.dart';
import '../../../widgets/progress/circular_progress.dart';
import '../../lists/list_view_popup.dart';

/// Screen to present a song in slide format
class SongPresentor extends StatefulWidget {
  const SongPresentor({Key? key}) : super(key: key);

  @override
  SongPresentorState createState() => SongPresentorState();
}

@visibleForTesting
class SongPresentorState extends State<SongPresentor>
    implements SongPresentorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SongPresentorVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<SongPresentorVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;
          vm.size = size;

          var appBarWidget = AppBar(
            title: Text(vm.songTitle),
            actions: <Widget>[
              InkWell(
                onTap: vm.likeSong,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(vm.likeIcon),
                ),
              ),
              InkWell(
                onTap: () async {
                  await showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return ListViewPopup(song: vm.song!);
                      });
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.list),
                ),
              ),
            ],
          );

          return Scaffold(
            backgroundColor: ThemeColors.backgroundGrey,
            appBar: appBarWidget,
            body: SizedBox(
              height: size!.height,
              child: vm.isBusy
                  ? const CircularProgress()
                  : vm.widgetTabs.isNotEmpty
                      ? PresentOnMobile(
                          index: vm.curSlide,
                          tabsElevation: 5,
                          songbook: vm.songBook,
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
            floatingActionButton: ExpandableFab(
              distance: 112.0,
              children: [
                FloatingActionButton(
                  heroTag: 'share_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: () {
                    Share.share(
                      '${vm.songTitle}\n${vm.songBook}\n\n${vm.songContent}',
                      subject: 'Share Song',
                    );
                  },
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'copy_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: vm.copySong,
                  child: const Icon(Icons.copy, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'edit_fab',
                  backgroundColor: ThemeColors.primary,
                  onPressed: () => vm.navigator.goToSongEditor(),
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
  void goToSongEditor() => MainNavigator.of(context).goToSongEditor();

  @override
  void goToSongEditorPc() => MainNavigator.of(context).goToSongEditorPc();

  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();
}
