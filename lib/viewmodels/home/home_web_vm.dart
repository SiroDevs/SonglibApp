import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/base/book.dart';
import '../../model/base/songext.dart';
import '../../model/general/general.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../repository/web_repository.dart';
import '../../utils/utilities.dart';
import '../../widgets/general/toast.dart';

@injectable
class HomeWebVm with ChangeNotifier {
  late final HomeWebNavigator navigator;
  final WebRepository api;
  final DbRepository db;
  final LocalStorage localStorage;

  HomeWebVm(this.api, this.db, this.localStorage);

  AppLocalizations? tr;
  BuildContext? context;

  bool isBusy = false, isMiniLoading = false, hasError = false;
  bool isSearching = false, shownUpdateHint = false;
  List<Book>? books = [];

  String songTitle = 'Song Title', songTitleL = 'Song Title';
  String currentUpdate = 'update68';
  List<SongExt>? filtered = [], songs = [];
  List<String> verses = [];

  Book setBook = Book();
  SongExt setSong = SongExt();

  TextEditingController? searchController = TextEditingController();
  TextEditingController? titleController, contentController;
  PageType setPage = PageType.search;

  String selectedBooks = "", errorTitle = "", errorBody = "";
  List<int> bookNos = [];

  List<PageType> pages = [
    PageType.search,
    PageType.helpdesk,
  ];

  Future<void> init(HomeWebNavigator screenNavigator) async {
    navigator = screenNavigator;

    await fetchData();
  }

  /// Get the data from the DB
  Future<void> fetchData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();

    await fetchBooks();
    await fetchSongs();
    await selectSongbook(books![0]);

    isBusy = false;
    notifyListeners();
  }

  /// Get the list of books
  Future<List<Book>?> fetchBooks() async {
    isBusy = true;
    notifyListeners();

    if (await isConnected()) {
      /*var response = await api.fetchBooks();
      if (response.id == EventConstants.requestSuccessful) {
        Book book = Book();
        books = book.fromParse(response.data);
        for (var getBook in books!) {
          bookNos.add(getBook.bookNo!);
        }
      } else {
        hasError = true;
      }*/
    } else {
      hasError = true;
      errorTitle = tr!.noConnection;
      errorBody = tr!.noConnectionBody;
    }

    isBusy = false;
    notifyListeners();
    return books;
  }

  /// Get the list of songs and save theme
  Future<void> fetchSongs() async {
    isBusy = true;
    notifyListeners();

    if (await isConnected()) {
      //var response = await api.fetchSongs(bookNos);
      /*if (response.id == EventConstants.requestSuccessful) {
        Song webSong = Song();
        List<Song> webSongs = webSong.fromData(response.data);
        songs!.clear();
        for (var song in webSongs) {
          Book sbook = books!.firstWhere((b) => b.bookNo == song.book);
          songs!.add(
            SongExt(
              songbook: sbook.title,
              songNo: song.songNo,
              book: song.book,
              title: song.title,
              alias: song.alias,
              content: song.content,
              views: song.views,
              likes: song.likes,
              liked: song.liked,
              author: song.author,
              key: song.key,
              id: song.id,
            ),
          );
        }
      } else {
        hasError = true;
      }*/
    } else {
      hasError = true;
      errorTitle = tr!.noConnection;
      errorBody = tr!.noConnectionBody;
    }

    isBusy = false;
    notifyListeners();
  }

  /// Set songbook
  Future<void> selectSongbook(Book book, {bool showLoading = true}) async {
    isSearching = false;
    if (showLoading) isBusy = true;
    notifyListeners();
    setBook = book;

    try {
      filtered!.clear();
      for (int i = 0; i < songs!.length; i++) {
        if (songs![i].book == setBook.bookNo) {
          filtered!.add(songs![i]);
        }
      }
      chooseSong(filtered![0]);
    } catch (exception) {}

    isBusy = false;
    notifyListeners();
  }

  void onSearch(String query) async {
    if (query.isNotEmpty) {
      switch (setPage) {
        case PageType.lists:
          break;
        case PageType.search:
          isSearching = true;
          filtered = seachSongByQuery(query, songs!);
          break;
        case PageType.likes:
          if (query.isNotEmpty) {}
          break;
        case PageType.drafts:
          if (query.isNotEmpty) {}
          break;
        default:
          break;
      }
    }
    notifyListeners();
  }

  void setCurrentPage(PageType page) async {
    setPage = page;
    searchController!.clear();
    notifyListeners();
  }

  void chooseSong(SongExt song) {
    setSong = song;
    verses = song.content!.split("##");
    songTitle = songItemTitle(song.songNo!, song.title!);
    notifyListeners();
  }

  Future<void> copySong(SongExt song) async {
    await Clipboard.setData(ClipboardData(
      text:
          '${songItemTitle(song.songNo!, song.title!)}\n${refineTitle(song.songbook!)}'
          '\n\n${song.content!.replaceAll("#", "\n")}',
    ));
    showToast(
      text: '${song.title} ${tr!.songCopied}',
      state: ToastStates.success,
    );
  }

  Future<void> shareSong(SongExt song) async {
    await Share.share(
      '${songItemTitle(song.songNo!, song.title!)}\n${refineTitle(song.songbook!)}'
      '\n\n${song.content!.replaceAll("#", "\n")}',
      subject: tr!.shareVerse,
    );
  }
}

abstract class HomeWebNavigator {}
