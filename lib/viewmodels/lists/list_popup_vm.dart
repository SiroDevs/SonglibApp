import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/listed.dart';
import '../../model/base/listedext.dart';
import '../../model/base/songext.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class ListPopupVm with ChangeNotifier {
  late final ListPopupNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  ListPopupVm(this.dbRepo, this.localStorage);
  TextEditingController? titleController, contentController;

  BuildContext? context;
  AppLocalizations? tr;
  HomeVm? homeVm;
  List<ListedExt>? listeds = [];

  bool isBusy = false;

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
    } catch (exception) {}
    return listeds;
  }

  /// Add a song to a list
  Future<void> addSongToList(Listed listed, SongExt song) async {
    isBusy = true;
    notifyListeners();
    await dbRepo.saveListedSong(listed, song);
    showToast(
      text: '${song.title} ${tr!.songAddedToList}',
      state: ToastStates.success,
    );
    try {
      isBusy = false;
      notifyListeners();
    // ignore: empty_catches
    } catch (e) {
    }
  }

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveNewList() async {
    if (titleController!.text.isNotEmpty) {
      isBusy = true;
      notifyListeners();
      final Listed listed = Listed(
        listedId: 0,
        title: titleController!.text,
        description: contentController!.text,
      );
      await dbRepo.saveListed(listed);
      await fetchListedData();
      showToast(
        text: '${listed.title} ${tr!.listCreated}',
        state: ToastStates.success,
      );

      isBusy = false;
      notifyListeners();
    }
  }

}

abstract class ListPopupNavigator {
  void goToPresentor();
}
