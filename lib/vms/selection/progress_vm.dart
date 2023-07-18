import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/song.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../utils/constants/event_constants.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/utilities.dart';
import '../../webservice/app_web_service.dart';

@injectable
class ProgressVm with ChangeNotifierEx {
  late final ProgressNavigator navigator;
  final AppWebService api;
  final DbRepository db;
  final LocalStorage localStorage;

  int progress = 0;
  String state = '';
  String time = '00:00';

  ProgressVm(this.api, this.db, this.localStorage);

  AppLocalizations? tr;
  bool isLoading = false, hasError = false, onBoarded = false;
  String errorTitle = "", errorBody = "";
  String selectedBooks = "", predistinatedBooks = "";
  List<Song>? songs = [];
  List<String> newBooks = [], oldBooks = [], predistinated = [], selected = [];
  List<int> bookNos = [];

  Future<void> init(ProgressNavigator screenNavigator) async {
    navigator = screenNavigator;

    onBoarded = localStorage.getPrefBool(PrefConstants.onboardedCheckKey);
    selectedBooks = localStorage.getPrefString(PrefConstants.selectedBooksKey);
    predistinatedBooks =
        localStorage.getPrefString(PrefConstants.predistinatedBooksKey);

    if (predistinatedBooks.isNotEmpty) {
      isLoading = true;
      notifyListeners();
      await db.majorCleanUp(selectedBooks);
    }

    await fetchSongs();
  }

  /// Get the list of songs and save theme
  Future<void> fetchSongs() async {
    isLoading = true;
    notifyListeners();

    selected = selectedBooks.split(",");
    for (final select in selected) {
      bookNos.add(int.parse(select));
    }
    //songs = await api.fetchSongs(bookNos);

    if (await isConnected()) {
      var response = await api.fetchSongs(bookNos);
      if (response.id == EventConstants.requestSuccessful) {
        Song song = Song();
        songs = song.fromData(response.data);

        if (songs!.isNotEmpty) {
          await saveSongs();
        } else {
          hasError = true;
        }
      } else {
        hasError = true;
      }
    } else {
      hasError = true;
      errorTitle = tr!.noConnection;
      errorBody = tr!.noConnectionBody;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Get the list of songs and save theme
  Future<void> saveSongs() async {
    isLoading = false;
    notifyListeners();

    if (songs!.isNotEmpty) {
      for (int i = 0; i < songs!.length; i++) {
        try {
          progress = (i / songs!.length * 100).toInt();

          switch (progress) {
            case 1:
              state = "On your\nmarks ...";
              break;
            case 5:
              state = "Set,\nReady ...";
              break;
            case 10:
              state = "Loading\nsongs ...";
              break;
            case 20:
              state = "Patience\npays ...";
              break;
            case 40:
              state = "Loading\nsongs ...";
              break;
            case 75:
              state = "Thanks for\nyour patience!";
              break;
            case 85:
              state = "Finishing up";
              break;
            case 95:
              state = "Almost done";
              break;
          }
          notifyListeners();

          await db.saveSong(songs![i]);
        } catch (_) {}
      }
    }

    localStorage.setPrefBool(PrefConstants.dataLoadedCheckKey, true);
    localStorage.setPrefBool(PrefConstants.wakeLockCheckKey, true);

    if (onBoarded) {
      navigator.goToHome();
    } else {
      navigator.goToOnboarding();
    }
  }
}

abstract class ProgressNavigator {
  void goToHome();
  void goToOnboarding();
}
