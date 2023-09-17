import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../di/injectable.dart';
import '../../model/base/draft.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../home/home_vm.dart';

@injectable
class DraftEditorVm with ChangeNotifier {
  late final DraftEditorNavigator navigator;
  final LocalStorage localStorage;
  final DbRepository dbRepo;

  DraftEditorVm(this.dbRepo, this.localStorage);

  HomeVm? homeVm;
  Draft? draft;

  bool isBusy = false, notEmpty = false;
  String? title, content, alias, key;
  String? pageTitle = 'Draft a New Song';
  TextEditingController? titleController = TextEditingController();
  TextEditingController? contentController = TextEditingController();
  TextEditingController? aliasController = TextEditingController();
  TextEditingController? keyController = TextEditingController();

  Future<void> init(DraftEditorNavigator screenNavigator) async {
    navigator = screenNavigator;

    homeVm = HomeVm(dbRepo, localStorage);
    homeVm = getIt.get<HomeVm>();
    await loadEditor();
  }

  Future<void> loadEditor() async {
    isBusy = true;
    notifyListeners();

    if (notEmpty) {
      draft = localStorage.draft;
      pageTitle = 'Edit Your Draft';
      titleController!.text = draft!.title!;
      aliasController!.text = draft!.alias!;
      keyController!.text = draft!.key!;
      contentController!.text = draft!.content!;
    }

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

      if (draft != null) {
        draft!.title = title;
        draft!.content = content;
        draft!.alias = alias;
        draft!.key = key;
        await dbRepo.editDraft(draft!);
      } else {
        draft = Draft(
          title: title,
          content: content,
          alias: alias,
          key: key,
        );
        await dbRepo.saveDraft(draft!);
      }
      homeVm!.drafts = await dbRepo.fetchDrafts();
      isBusy = false;
      notifyListeners();
      //await onBackPressed();
    }
  }

  /// Remove a song from the records
  Future<bool?> deleteDraft() async {
    bool? success;

    if (validateInput()) {
      isBusy = true;
      notifyListeners();

      //await dbRepo.d(draft!);

      isBusy = true;
      notifyListeners();
    }
    return success;
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
                Navigator.pop(context);
                saveChanges();
                homeVm!.fetchDraftsData();
              },
              child: const Text("SAVE"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                //onBackPressed();
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
      //await onBackPressed();
    }
  }

  Future<void> confirmDelete(BuildContext context) async {
    if (validateInput()) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            'Just a Minute',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete the song: ${titleController!.text}?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteDraft();
                homeVm!.fetchDraftsData();
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
    } else {
      //await onBackPressed();
    }
  }

}

abstract class DraftEditorNavigator {}
