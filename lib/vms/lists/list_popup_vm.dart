import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../models/base/listed.dart';
import '../../models/base/listedext.dart';
import '../../models/base/songext.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class ListPopupVm with ChangeNotifierEx {
  late final ListPopupNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  ListPopupVm(this.dbRepo, this.localStorage);
  TextEditingController? titleController, contentController;

  BuildContext? context;
  AppLocalizations? tr;
  HomeVm? homeVm;
  List<ListedExt>? listeds = [];

  bool isLoading = false;

  Future<void> init(ListPopupNavigator screenNavigator) async {
    navigator = screenNavigator;
    tr = AppLocalizations.of(context!)!;
    titleController = TextEditingController();
    contentController = TextEditingController();
    homeVm = GetIt.instance<HomeVm>();
  }

  /// Get the listed data from the DB
  Future<List<Listed>?> fetchListedData() async {
    List<Listed>? listeds = [];
    try {
      listeds = await dbRepo.fetchListeds();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    return listeds;
  }

  /// Add a song to a list
  Future<void> addSongToList(Listed listed, SongExt song) async {
    isLoading = true;
    notifyListeners();
    await dbRepo.saveListedSong(listed, song);
    showToast(
      text: '${song.title} ${tr!.songAddedToList}',
      state: ToastStates.success,
    );
    try {
      isLoading = false;
      notifyListeners();
    // ignore: empty_catches
    } catch (e) {
    }
  }

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveNewList() async {
    if (titleController!.text.isNotEmpty) {
      isLoading = true;
      notifyListeners();
      final Listed listed = Listed(
        objectId: '',
        title: titleController!.text,
        description: contentController!.text,
      );
      await dbRepo.saveListed(listed);
      await fetchListedData();
      showToast(
        text: '${listed.title} ${tr!.listCreated}',
        state: ToastStates.success,
      );

      isLoading = false;
      notifyListeners();
    }
  }

  void onBackPressed() => navigator.goBack<void>();
}

abstract class ListPopupNavigator implements BackNavigator {
  void goToPresentor();
}
