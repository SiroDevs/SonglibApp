import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../exports.dart';

/// The controller for the Home screen
class HomeController extends GetxController {
  final GetStorage userData = GetStorage();

  final ScrollController bookListScrollController = ScrollController();
  final ScrollController songListScrollController = ScrollController();

  bool isLoading = false, isSearching = false;
  String selectedBooks = "";
  int mainBook = 0;

  List<Book>? books = [];
  List<Song>? fullList = [], bookList = [];
  MyDatabase? db;

  int selectedTab = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  

  @override
  void onInit() {
    super.onInit();
    selectedBooks = userData.read(PrefKeys.selectedBooks);
    var bookids = selectedBooks.split(",");
    mainBook = int.parse(bookids[0]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onTabTapped(int index) {
    selectedTab = index;
    update();
  }

  /// Get the list of books
  Future<List<Book>?> fetchBookList() async {
    books = await db!.bookList();
    return books;
  }

  /// Get the list of songs
  Future<List<Song>?> fetchFullSongList() async {
    fullList = await db!.songList();
    return fullList;
  }

  /// Get the list of songs
  Future<List<Song>?> fetchBookSongList() async {
    bookList = await db!.songList();
    bookList!.removeWhere((item) => item.book != mainBook);
    return bookList;
  }

  /// Get the list of songs for the current book
  Future<void> resetBookSongList(Book book) async {
    bookList = fullList;
    mainBook = book.bookid!;
    bookList!.removeWhere((item) => item.book != mainBook);
    update();
  }
}
