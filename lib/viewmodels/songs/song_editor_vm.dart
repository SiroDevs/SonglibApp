import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

import '../../di/injectable.dart';
import '../../model/base/songext.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../home/home_vm.dart';

@injectable
class SongEditorVm with ChangeNotifier {
  late final SongEditorNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  SongEditorVm(this.dbRepo, this.localStorage);

  HomeVm? homeVm;
  SongExt? song;

  BuildContext? context;
  AppLocalizations? tr;

  bool isBusy = false, notEmpty = false;
  String? title, content, alias, key;
  TextEditingController? titleController = TextEditingController();
  TextEditingController? contentController = TextEditingController();
  TextEditingController? aliasController = TextEditingController();
  TextEditingController? keyController = TextEditingController();

  Future<void> init(SongEditorNavigator screenNavigator) async {
    navigator = screenNavigator;

    song = localStorage.song;

    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    await loadEditor();
  }

  Future<void> loadEditor() async {
    isBusy = true;
    notifyListeners();

    titleController!.text = song!.title!;
    aliasController!.text = song!.alias!;
    keyController!.text = song!.key!;
    contentController!.text = song!.content!.replaceAll('#', '\n');

    isBusy = false;
    notifyListeners();
  }

  // function to validate creds
  bool validateInput() {
    bool validated = false;
    if (titleController!.text.isNotEmpty) {
      title = titleController!.text;
      content = contentController!.text.replaceAll(RegExp(r'[\n]'), '#');
      alias = aliasController!.text;
      key = keyController!.text;

      validated = true;
    } else {
      validated = false;
    }
    return validated;
  }

  /// Save changes for a song be it a new one or simply updating an old one
  Future<void> saveChanges() async {
    if (validateInput()) {
      isBusy = true;
      notifyListeners();

      try {
        if (song != null) {
          song!.title = title;
          song!.content = content;
          song!.alias = alias;
          song!.key = key;
          await dbRepo.editSong(song!);
        }
    } catch (exception) {}

      await onBackPressed();
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> confirmCancel(BuildContext context) async {
    if (validateInput()) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Just a Minute',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to close without saving your changes of the song: ${titleController!.text}?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                saveChanges();
                homeVm!.fetchDraftsData();
                Navigator.pop(context);
              },
              child: const Text("SAVE"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onBackPressed();
              },
              child: const Text("DON'T SAVE"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
          ],
        ),
      );
    } else {
      await onBackPressed();
    }
  }

  Future<void> onBackPressed() async {
    //Navigator.pop(context, true);
  }
}

abstract class SongEditorNavigator {}
