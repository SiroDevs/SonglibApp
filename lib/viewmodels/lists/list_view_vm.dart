import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

import '../../di/injectable.dart';
import '../../model/base/listed.dart';
import '../../model/base/listedext.dart';
import '../../model/base/songext.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../widgets/general/toast.dart';
import '../home/home_vm.dart';

@injectable
class ListViewVm with ChangeNotifier {
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

  bool isBusy = false, showSearch = false;
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

  /// Show search widget
  Future<void> showSearchWidget(bool show) async {
    showSearch = show;
    notifyListeners();
  }

  /// Get the data from the DB
  Future<void> fetchData() async {
    isBusy = true;
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
    isBusy = false;
    notifyListeners();
  }

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveChanges() async {
    if (titleController!.text.isNotEmpty) {
      isBusy = true;
      notifyListeners();
      listed!.title = titleController!.text;
      listed!.description = contentController!.text;
      await dbRepo.editListed(listed!);
      showToast(
        text: '${listed!.title} ${tr!.listUpdated}',
        state: ToastStates.success,
      );
      isBusy = false;
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
              dbRepo.removeListed(listed!.id!);
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
    isBusy = true;
    notifyListeners();
    await dbRepo.saveListedSong(listed!, song);
    await showSearchWidget(false);
    await fetchData();
    showToast(
      text: '${song.title} ${tr!.songAddedToList}',
      state: ToastStates.success,
    );
    isBusy = false;
    notifyListeners();
  }

  void onBackPressed() {}
}

abstract class ListViewNavigator {
  void goToSongPresentor();
  void goToSongPresentorPc();
}
