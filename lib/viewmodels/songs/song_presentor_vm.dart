import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock/wakelock.dart';

import '../../di/injectable.dart';
import '../../model/base/history.dart';
import '../../model/base/songext.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/utilities.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class SongPresentorVm with ChangeNotifier {
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  SongPresentorVm(this.dbRepo, this.localStorage);

  late final SongPresentorNavigator navigator;
  late HomeVm homeVm;
  SongExt? song;

  bool isBusy = false, enableWakeLock = false, slideHorizontal = false;
  bool isLiked = false, hasChorus = false, shownPcHints = false;

  String pageTitle = '...', songTitle = '', songBook = '', songContent = '';
  int curStanza = 0, curSong = 0, curSlide = 0;
  List<String> songVerses = [], verseInfos = [], verseTexts = [];

  BuildContext? context;
  AppLocalizations? tr;
  Size? size;
  double fSize = 25;
  List<Tab> widgetTabs = [];
  List<Widget> widgetContent = [];

  IconData likeIcon = Icons.favorite_border;

  Future<void> init(SongPresentorNavigator screenNavigator) async {
    navigator = screenNavigator;

    song = localStorage.song;
    enableWakeLock = localStorage.getPrefBool(PrefConstants.wakeLockCheckKey);
    shownPcHints = localStorage.getPrefBool(PrefConstants.pcHintsKey);
    slideHorizontal =
        localStorage.getPrefBool(PrefConstants.slideHorizontalKey);
    if (enableWakeLock) await Wakelock.enable();

    isBusy = true;
    notifyListeners();
    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    fSize = (size!.height * 0.0489).toDouble();
    await loadPresentor();
    if (isDesktop && !shownPcHints) hintsDialog(context!);
  }

  /// Prepare song lyrics to be shown in slide format
  Future<void> loadPresentor() async {
    isBusy = true;
    notifyListeners();

    verseInfos.clear();
    verseTexts.clear();

    await loadSong();
    await dbRepo.saveHistory(History(song: song!.id));
    pageTitle = '$songTitle - $songBook';
    isBusy = false;
    notifyListeners();
  }

  Future<void> loadSong() async {
    songBook = refineTitle(song!.songbook!);
    songTitle = songItemTitle(song!.songNo!, song!.title!);

    isLiked = song!.liked != null ? song!.liked! : false;
    likeIcon = isLiked ? Icons.favorite : Icons.favorite_border;
    songVerses = song!.content!.split("##");
    final int verseCount = songVerses.length;

    if (song!.content!.contains("CHORUS")) {
      hasChorus = true;
    } else {
      hasChorus = false;
    }

    if (hasChorus) {
      final String chorus = songVerses[1].toString().replaceAll("CHORUS#", "");

      verseInfos.add("1");
      verseInfos.add("C");
      verseTexts.add(songVerses[0]);
      verseTexts.add(chorus);

      for (int i = 2; i < verseCount; i++) {
        verseInfos.add(i.toString());
        verseInfos.add("C");
        verseTexts.add(songVerses[i]);
        verseTexts.add(chorus);
      }
    } else {
      for (int i = 0; i < verseCount; i++) {
        verseInfos.add((i + 1).toString());
        verseTexts.add(songVerses[i]);
      }
    }

    // Generate presentor slides
    for (final verse in verseInfos) {
      widgetTabs.add(
        Tab(
          child: PresentorInfo(
            info: verse,
            fontSize: fSize * .75,
          ),
        ),
      );
    }
    for (final verse in verseTexts) {
      widgetContent.add(
        PresentorText(
          lyrics: verse,
          size: size!,
          onDoubleTap: () => Share.share(
            '${verse.replaceAll("#", "\n")}\n\n$songTitle,\n$songBook',
            subject: tr!.shareVerse,
          ),
          onLongPress: () => copyVerse(verse),
        ),
      );
    }
  }

  /// Add a song to liked songs
  Future<void> likeSong() async {
    isLiked = !isLiked;
    song!.liked = isLiked;
    await dbRepo.editSong(song!);
    likeIcon = isLiked ? Icons.favorite : Icons.favorite_border;
    if (isLiked) {
      showToast(
        text: '${song!.title} ${tr!.songLiked}',
        state: ToastStates.success,
      );
    }
    notifyListeners();
  }

  /// Add a song to liked songs
  Future<void> copySong() async {
    await Clipboard.setData(ClipboardData(
      text: '$songTitle\n$songBook\n\n$songContent',
    ));
    showToast(
      text: '$songTitle ${tr!.songCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> copyVerse(String lyrics) async {
    await Clipboard.setData(
      ClipboardData(
        text: '${lyrics.replaceAll("#", "\n")}\n\n$songTitle,\n$songBook',
      ),
    );
    showToast(
      text: 'Verse ${tr!.textCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> hintsDialog(BuildContext context) async {
    var result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: tr!.keyboardShortcuts,
      text: tr!.keyboardShortcutsTexts,
      iconStyle: IconStyle.information,
      //neutralButtonTitle: tr!.donate,
      positiveButtonTitle: tr!.okay,
    );
    if (result == CustomButton.neutralButton) {
      localStorage.setPrefBool(PrefConstants.pcHintsKey, true);
      navigator.goToDonation();
    }
    if (result == CustomButton.positiveButton) {
      localStorage.setPrefBool(PrefConstants.pcHintsKey, true);
    }
  }
}

abstract class SongPresentorNavigator {
  void goToSongEditor();
  void goToSongEditorPc();
  void goToDonation();
}
