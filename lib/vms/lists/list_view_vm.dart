import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../di/injectable.dart';
import '../../models/base/listed.dart';
import '../../models/base/listedext.dart';
import '../../models/base/songext.dart';
import '../../navigator/mixin/back_navigator.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class ListViewVm with ChangeNotifierEx {
  late final ListViewNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  ListViewVm(this.dbRepo, this.localStorage);

  AppLocalizations? tr;
  HomeVm? homeVm;
  Listed? listed;
  String songTitle = 'Song Title', listTitle = "List Title";
  SongExt setSong = SongExt();
  List<ListedExt>? listeds = [];
  List<SongExt>? songs = [], listSongs = [];

  bool isLoading = false, showSearch = false;
  TextEditingController? titleController, contentController;

  Future<void> init(ListViewNavigator screenNavigator) async {
    navigator = screenNavigator;

    listed = localStorage.listed;
    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    titleController = TextEditingController(text: listed!.title ?? '');
    contentController = TextEditingController(text: listed!.description ?? '');

    await fetchData();
  }

  /// Show search widgets
  Future<void> showSearchWidget(bool show) async {
    showSearch = show;
    notifyListeners();
  }

  /// Get the data from the DB
  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();
    listTitle = listed!.title!;

    songs = await dbRepo.fetchSongs();
    listeds = await dbRepo.fetchListedSongs(listed!.id!);
    for (var listed in listeds!) {
      listSongs!.add(
        SongExt(
          songbook: listed.songbook,
          songNo: listed.songNo,
          book: listed.book,
          title: listed.title,
          alias: listed.alias,
          content: listed.content,
          views: listed.views,
          likes: listed.likes,
          liked: listed.liked,
          author: listed.author,
          key: listed.key,
          id: listed.songId,
        ),
      );
    }
    setSong = songs![0];
    isLoading = false;
    notifyListeners();
  }

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveChanges() async {
    if (titleController!.text.isNotEmpty) {
      isLoading = true;
      notifyListeners();
      listed!.title = titleController!.text;
      listed!.description = contentController!.text;
      await dbRepo.editListed(listed!);
      showToast(
        text: '${listed!.title} ${tr!.listUpdated}',
        state: ToastStates.success,
      );
      isLoading = false;
      notifyListeners();
    }
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
          'Are you sure you want to delete the song list: ${listed!.title}?',
          style: const TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              showToast(
                text: '${listed!.title} ${tr!.deleted}',
                state: ToastStates.success,
              );
              Navigator.pop(context);
              dbRepo.removeListed(listed!);
              homeVm!.fetchListedData();
              onBackPressed();
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

  /// Add a song to a list
  Future<void> addSongToList(SongExt song) async {
    isLoading = true;
    notifyListeners();
    await dbRepo.saveListedSong(listed!, song);
    await showSearchWidget(false);
    await fetchData();
    showToast(
      text: '${song.title} ${tr!.songAddedToList}',
      state: ToastStates.success,
    );
    isLoading = false;
    notifyListeners();
  }

  void onBackPressed() => navigator.goBack<void>();
}

abstract class ListViewNavigator implements BackNavigator {
  void goToSongPresentor();
  void goToSongPresentorPc();
}
