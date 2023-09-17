import 'dart:convert';
import 'dart:developer' as logger show log;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/book.dart';
import '../../model/base/song.dart';
import '../../model/general/general.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../repository/web_repository.dart';
import '../../utils/constants/pref_constants.dart';

@injectable
class SelectionVm with ChangeNotifier {
  late final SelectionNavigator navigator;
  final WebRepository api;
  final DbRepository db;
  final LocalStorage localStorage;

  SelectionVm(this.api, this.db, this.localStorage);

  BuildContext? context;
  AppLocalizations? tr;
  List<Selectable<Book>?> selectables = [], listedBooks = [];
  List<Book>? books = [];
  int currentPage = 0, progress = 0;
  String state = '', time = '00:00';

  String feedbackTitle = "", feedbackMessage = "";
  bool isBusy = false, failure = false, success = false, hasError = false;

  String selectedBooks = "", predistinatedBooks = "";
  List<Song>? songs = [];
  List<String> newBooks = [], oldBooks = [], predistinated = [], selected = [];
  List<int> bookNos = [];

  Future<void> init(SelectionNavigator screenNavigator) async {
    navigator = screenNavigator;

    selectedBooks = localStorage.getPrefString(PrefConstants.selectedBooksKey);
    if (selectedBooks.isNotEmpty) {
      bookNos = selectedBooks.split(",").cast<int>();
    }
    await fetchBooks();
  }

  Future<void> manageFeedBack(
      bool isSuccess, bool isFailure, String title, String message) async {
    success = isSuccess;
    failure = isFailure;
    feedbackTitle = title;
    feedbackMessage = message;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5), () {});
    success = failure = false;
    notifyListeners();
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
  Future<void> fetchBooks() async {
    isBusy = true;
    notifyListeners();
    var response = await api.fetchBooks();

    isBusy = false;
    notifyListeners();
    var resp = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<dynamic> dataList = resp['data'];
      books = dataList.map((item) => Book.fromJson(item)).toList();

      if (books!.isNotEmpty) {
        for (final book in books!) {
          bool predistinated = false;
          if (bookNos.contains(book.bookNo)) predistinated = true;
          listedBooks.add(Selectable<Book>(book, predistinated));
        }
      }
    } else if (response.statusCode == 404) {
      manageFeedBack(
          false, true, '', 'Fetching songbooks data failed with code 404');
    } else if (response.statusCode == 500) {
      manageFeedBack(
          false, true, tr!.labelError500, tr!.labelErrorConnectionText);
    } else if (response.statusCode == 504) {
      manageFeedBack(
          false, true, tr!.labelError504, tr!.labelErrorConnectionText);
    } else {
      manageFeedBack(false, true, '', resp['statusMessage']);
    }
  }

  /// Proceed to a saving books data
  Future<void> saveBooks() async {
    isBusy = true;
    notifyListeners();

    //try {
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
    //} catch (_) {}

    try {
      selectedBooks = selectedBooks.substring(0, selectedBooks.length - 1);
    } catch (e) {
      logger.log('Error while sorting $selectedBooks: $e');
    }

    isBusy = false;
    notifyListeners();

    localStorage.setPrefString(PrefConstants.selectedBooksKey, selectedBooks);
    fetchAndSaveSongs();
  }

  /// Get the list of songs and save them
  Future<void> fetchAndSaveSongs() async {
    currentPage = 1;
    isBusy = true;
    notifyListeners();
    var response = await api.fetchSongs(selectedBooks);

    isBusy = false;
    notifyListeners();
    var resp = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<dynamic> dataList = resp['data'];
      songs = dataList.map((item) => Song.fromJson(item)).toList();

      if (songs!.isNotEmpty) {
        logger.log('Savings songs to the db');
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
                state = "Almost done ...";
                break;
            }
            notifyListeners();

            await db.saveSong(songs![i]);
          } catch (e) {
            logger.log(e.toString());
          }
          logger.log(state);
        }
      }
    } else if (response.statusCode == 404) {
      manageFeedBack(
          false, true, '', 'Fetching songs data failed with code 404');
    } else if (response.statusCode == 500) {
      manageFeedBack(
          false, true, tr!.labelError500, tr!.labelErrorConnectionText);
    } else if (response.statusCode == 504) {
      manageFeedBack(
          false, true, tr!.labelError504, tr!.labelErrorConnectionText);
    } else {
      manageFeedBack(false, true, '', resp['statusMessage']);
    }

    localStorage.setPrefBool(PrefConstants.dataLoadedCheckKey, true);
    localStorage.setPrefBool(PrefConstants.wakeLockCheckKey, true);

    /*if (onBoarded) {
      navigator.goToHome();
    } else {
      navigator.goToOnboarding();
    }*/
    navigator.goToHome();
  }
}

abstract class SelectionNavigator {
  void goToHome();
  void goToOnboarding();
}
