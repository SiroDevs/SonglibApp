import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/book.dart';
import '../../models/general/general.dart';
import '../../repository/db_repository.dart';
import '../../repository/shared_prefs/local_storage.dart';
import '../../utils/constants/event_constants.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/utilities.dart';
import '../../webservice/app_web_service.dart';

@injectable
class SelectionVm with ChangeNotifierEx {
  late final SelectionNavigator navigator;
  final AppWebService api;
  final DbRepository db;
  final LocalStorage localStorage;

  SelectionVm(this.api, this.db, this.localStorage);

  AppLocalizations? tr;
  bool isLoading = false, hasError = false;
  List<Selectable<Book>?> selectables = [], listedBooks = [];
  List<Book>? books = [];

  String selectedBooks = "", errorTitle = "", errorBody = "";
  List<String> bookNos = [];

  Future<void> init(SelectionNavigator screenNavigator) async {
    navigator = screenNavigator;

    selectedBooks = localStorage.getPrefString(PrefConstants.selectedBooksKey);
    if (selectedBooks.isNotEmpty) {
      bookNos = selectedBooks.split(",");
    }
    await fetchBooks();
  }

  void onBookSelected(int index) {
    try {
      listedBooks[index]!.isSelected = !listedBooks[index]!.isSelected;

      if (listedBooks[index]!.isSelected) {
        selectables.add(listedBooks[index]);
      } else {
        selectables.remove(listedBooks[index]);
      }
      notifyListeners();
    } catch (_) {}
  }

  /// Get the list of books
  Future<List<Book>?> fetchBooks() async {
    isLoading = true;
    notifyListeners();

    if (await isConnected()) {
      var response = await api.fetchBooks();
      if (response.id == EventConstants.requestSuccessful) {
        Book book = Book();
        books = book.fromParse(response.data);
        if (books!.isNotEmpty) {
          for (final book in books!) {
            bool predistinated = false;
            if (bookNos.contains(book.bookNo.toString())) predistinated = true;
            listedBooks.add(Selectable<Book>(book, predistinated));
          }
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
    return books;
  }

  /// Proceed to a saving books data
  Future<void> saveBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      if (selectedBooks.isNotEmpty) {
        await db.removeBooks();
        localStorage.setPrefString(
            PrefConstants.predistinatedBooksKey, selectedBooks);
        selectedBooks = "";
      }
      for (int i = 0; i < selectables.length; i++) {
        final Book book = selectables[i]!.data;
        selectedBooks = "$selectedBooks${book.bookNo},";
        await db.saveBook(book);
      }
    } catch (_) {}

    try {
      selectedBooks = selectedBooks.substring(0, selectedBooks.length - 1);
    } catch (_) {}

    isLoading = false;
    notifyListeners();

    localStorage.setPrefString(PrefConstants.selectedBooksKey, selectedBooks);
    navigator.goToProgress();
  }
}

abstract class SelectionNavigator {
  void goToProgress();
}
