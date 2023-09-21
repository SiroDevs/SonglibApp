import 'dart:async';
import 'dart:developer' as logger show log;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/book.dart';
import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/listedext.dart';
import '../../model/base/song.dart';
import '../../model/base/songext.dart';
import '../../model/general/general.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../repository/web_repository.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/data_utils.dart';
import '../../widgets/general/toast.dart';

@singleton
class HomeVm with ChangeNotifier {
  late final HomeNavigator navigator;
  final WebRepository api;
  final DbRepository db;
  final LocalStorage localStorage;

  HomeVm(this.api, this.db, this.localStorage);
  AppLocalizations? tr;

  bool isBusy = false, isMiniLoading = false;
  bool isSearching = false, shownUpdateHint = false, isLoggedIn = false;
  int currentPage = 1, dateDiff = 0;
  BuildContext? context;

  List<Book>? books = [];

  String selectedBooks = "";
  String songTitle = 'Song Title', songTitleL = 'Song Title';
  List<SongExt>? filtered = [], songs = [], likes = [], listSongs = [];
  List<String> verses = [], versesLike = [], versesDraft = [];
  List<Song>? apiSongs = [];

  List<ListedExt>? listedSongs = [];
  List<Listed>? listeds = [];
  List<Draft>? drafts = [];

  Book setBook = Book();
  Draft setDraft = Draft();
  SongExt setSong = SongExt();
  SongExt setLiked = SongExt();
  Listed setListed = Listed();

  TextEditingController? searchController = TextEditingController();
  TextEditingController? titleController = TextEditingController();
  TextEditingController? contentController = TextEditingController();
  PageType setPage = PageType.search;

  Future<void> init(HomeNavigator screenNavigator) async {
    navigator = screenNavigator;
    logger.log('Opened HomeView');

    selectedBooks = localStorage.getPrefString(PrefConstants.selectedBooksKey);

     DataUtils.fetchSongs(iApi: api, iDb: db, books: selectedBooks);

    isBusy = true;
    notifyListeners();

    books = await db.fetchBooks();
    songs = await db.fetchSongs();
    likes = await db.fetchLikedSongs();
    listeds = await db.fetchListeds();
    drafts = await db.fetchDrafts();
    await selectSongbook(books![0]);

    isBusy = false;
    notifyListeners();
  }

  void chooseSong(SongExt song) {
    localStorage.song = setSong = song;
    verses = song.content!.split("##");
    songTitle = songItemTitle(song.songNo!, song.title!);
    notifyListeners();
  }

  void chooseLiked(SongExt song) {
    localStorage.song = setLiked = song;
    versesLike = song.content!.split("##");
    songTitleL = songItemTitle(song.songNo!, song.title!);
    notifyListeners();
  }

  void chooseDraft(Draft draft) {
    localStorage.draft = setDraft = draft;
    versesDraft = draft.content!.split("##");
    notifyListeners();
  }

  /// Get the listed data from the DB
  Future<void> fetchListedData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();
    listeds = await db.fetchListeds();
    setListed = listeds![0];
    isBusy = false;
    notifyListeners();
  }

  /// Get the data from the DB
  Future<void> fetchListedSongs() async {
    isMiniLoading = true;
    notifyListeners();

    listedSongs = await db.fetchListedSongs(setListed.id!);
    listSongs!.clear();
    for (var listed in listedSongs!) {
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

    isMiniLoading = false;
    notifyListeners();
  }

  /// Get the notes data from the DB
  Future<void> fetchDraftsData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();
    drafts = await db.fetchDrafts();
    setDraft = drafts![0];
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

  /// Get the data from the DB
  Future<void> fetchLikedSongs({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();

    try {
      likes = await db.fetchLikedSongs();
      setLiked = likes![0];
    } catch (exception) {}

    isBusy = false;
    notifyListeners();
  }

  /// Add a song to liked songs
  Future<void> likeSong(SongExt song) async {
    bool isLiked = false;
    isLiked = !isLiked;
    song.liked = isLiked;
    await db.editSong(song);
    likes = await db.fetchLikedSongs();
    if (setSong.liked!) {
      showToast(
        text: '${song.title} ${tr!.songLiked}',
        state: ToastStates.success,
      );
    }
    notifyListeners();
  }

  void onSearch(String query) async {
    if (query.isNotEmpty) {
      switch (setPage) {
        case PageType.lists:
          break;
        case PageType.search:
          isSearching = true;
          filtered = DataUtils.seachSongByQuery(query, songs!);
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

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveListChanges() async {
    if (titleController!.text.isNotEmpty) {
      isBusy = true;
      notifyListeners();
      setListed.title = titleController!.text;
      setListed.description = contentController!.text;
      await db.editListed(setListed);
      showToast(
        text: '${setListed.title} ${tr!.listUpdated}',
        state: ToastStates.success,
      );
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> deleteList(BuildContext context, Listed listed) async {
    var result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'Just a Minute',
      text: 'Are you sure you want to delete the song list: ${listed.title}?',
      iconStyle: IconStyle.information,
      neutralButtonTitle: 'Cancel',
      positiveButtonTitle: 'Delete',
    );

    if (result == CustomButton.positiveButton) {
      localStorage.listed = setListed = Listed();
      listSongs!.clear();
      db.removeListed(listed.id!);
      await fetchListedData(showLoading: false);
      showToast(
        text: '${listed.title} ${tr!.deleted}',
        state: ToastStates.success,
      );
    }
  }

  /// Add a song to a list
  Future<void> addSongToList(SongExt song) async {
    isMiniLoading = true;
    notifyListeners();

    await db.saveListedSong(setListed, song);
    await fetchListedSongs();
    showToast(
      text: '${song.title}${tr!.songAddedToList}${setListed.title} list',
      state: ToastStates.success,
    );

    isMiniLoading = false;
    notifyListeners();
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
      await db.saveListed(listed);
      await fetchListedData(showLoading: false);
      showToast(
        text: '${listed.title} ${tr!.listCreated}',
        state: ToastStates.success,
      );

      isBusy = false;
      notifyListeners();
    }
  }

  /// rebuild the widget tree
  void rebuild() async => notifyListeners();
}

abstract class HomeNavigator {
  void goToSongPresentor();
  void goToSongPresentorPc();
  void goToDraftPresentor();
  void goToDraftPresentorPc();
  void goToSongEditor();
  void goToSongEditorPc();
  void goToDraftEditor(bool notEmpty);
}
