import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock/wakelock.dart';

import '../../di/injectable.dart';
import '../../model/base/draft.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../theme/theme_colors.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/utilities.dart';
import '../../widgets/action/buttons.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class DraftPresentorVm with ChangeNotifier {
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  DraftPresentorVm(this.dbRepo, this.localStorage);

  late final DraftPresentorNavigator navigator;
  late HomeVm homeVm;
  Draft? draft;

  BuildContext? context;
  AppLocalizations? tr;
  bool isBusy = false, enableWakeLock = false, slideHorizontal = false;
  bool isLiked = false, hasChorus = false, shownPcHints = false;

  String draftTitle = '', draftBook = '', draftContent = '';
  int curStanza = 0, curDraft = 0, curSlide = 0;
  List<String> draftVerses = [], verseInfos = [], verseTexts = [];

  Size? size;
  List<Tab> widgetTabs = [];
  List<Widget> widgetContent = [];

  IconData likeIcon = Icons.favorite_border;

  Future<void> init(DraftPresentorNavigator screenNavigator) async {
    navigator = screenNavigator;

    draft = localStorage.draft;

    enableWakeLock = localStorage.getPrefBool(PrefConstants.wakeLockCheckKey);
    shownPcHints = localStorage.getPrefBool(PrefConstants.pcHintsKey);
    slideHorizontal =
        localStorage.getPrefBool(PrefConstants.slideHorizontalKey);
    if (enableWakeLock) await Wakelock.enable();

    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    await loadPresentor();
    if (isDesktop && !shownPcHints) hintsDialog(context!);
  }

  /// Prepare draft lyrics to be shown in slide format
  Future<void> loadPresentor() async {
    isBusy = true;
    notifyListeners();

    verseInfos.clear();
    verseTexts.clear();

    await loadDraft();

    isBusy = false;
    notifyListeners();
  }

  Future<void> loadDraft() async {
    draftBook = refineTitle('');
    draftTitle = refineTitle(draft!.title!);

    isLiked = draft!.liked!;
    likeIcon = isLiked ? Icons.favorite : Icons.favorite_border;
    draftVerses = draft!.content!.split("##");
    final int verseCount = draftVerses.length;

    if (draft!.content!.contains("CHORUS")) {
      hasChorus = true;
    } else {
      hasChorus = false;
    }

    if (hasChorus) {
      final String chorus = draftVerses[1].toString().replaceAll("CHORUS#", "");

      verseInfos.add("1");
      verseInfos.add("C");
      verseTexts.add(draftVerses[0]);
      verseTexts.add(chorus);

      for (int i = 2; i < verseCount; i++) {
        verseInfos.add(i.toString());
        verseInfos.add("C");
        verseTexts.add(draftVerses[i]);
        verseTexts.add(chorus);
      }
    } else {
      for (int i = 0; i < verseCount; i++) {
        verseInfos.add((i + 1).toString());
        verseTexts.add(draftVerses[i]);
      }
    }

    // Generate presentor slides
    for (final verse in verseInfos) {
      widgetTabs.add(
        Tab(
          child: PresentorInfo(info: verse, fontSize: size!.height * 0.0489),
        ),
      );
    }
    for (final verse in verseTexts) {
      widgetContent.add(PresentorText(
        lyrics: verse,
        size: size!,
        onDoubleTap: () => Share.share(
          '${verse.replaceAll("#", "\n")}\n\n$draftTitle,\n$draftBook',
          subject: tr!.shareVerse,
        ),
        onLongPress: () => copyVerse(verse),
      ));
    }
  }

  /// Add a draft to liked drafts
  Future<void> copyDraft() async {
    await Clipboard.setData(ClipboardData(
      text: '$draftTitle\n$draftBook\n\n$draftContent',
    ));
    showToast(
      text: '$draftTitle ${tr!.songCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> copyVerse(String lyrics) async {
    await Clipboard.setData(
      ClipboardData(
        text: '${lyrics.replaceAll("#", "\n")}\n\n$draftTitle,\n$draftBook',
      ),
    );
    showToast(
      text: 'Verse ${tr!.textCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> confirmDelete(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Just a Minute',
          style: TextStyle(fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to delete the draft: $draftTitle?',
          style: const TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              dbRepo.removeDraft(draft!.id!);
              Navigator.pop(context, true);
            },
            child: const Text("DELETE"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
        ],
      ),
    );
  }

  Future<void> hintsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          tr!.keyboardShortcuts,
          style: const TextStyle(
            fontSize: 22,
            color: ThemeColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          tr!.keyboardShortcutsTexts,
          style: const TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          SimpleButton(
            title: tr!.okay,
            onPressed: () {
              Navigator.pop(context);
              localStorage.setPrefBool(PrefConstants.pcHintsKey, true);
            },
          ),
        ],
      ),
    );
  }

}

abstract class DraftPresentorNavigator {
  void goToDraftEditor(bool notEmpty);
}
