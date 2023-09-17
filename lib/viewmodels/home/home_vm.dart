import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/base/book.dart';
import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/listedext.dart';
import '../../model/base/songext.dart';
import '../../model/general/general.dart';
import '../../repository/db_repository.dart';
import '../../repository/local_storage.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/utilities.dart';
import '../../widgets/general/toast.dart';

@singleton
class HomeVm with ChangeNotifier {
  late final HomeNavigator navigator;
  final DbRepository dbRepo;
  final LocalStorage localStorage;

  HomeVm(this.dbRepo, this.localStorage);
  AppLocalizations? tr;

  bool isBusy = false, isMiniLoading = false;
  bool isSearching = false, shownUpdateHint = false;
  bool isLoggedIn = false;
  int currentPage = 1, dateDiff = 0;
  BuildContext? context;

  List<Book>? books = [];

  String songTitle = 'Song Title', songTitleL = 'Song Title';
  String currentUpdate = 'update68', timeInstalled = "";
  List<SongExt>? filtered = [], songs = [], likes = [], listSongs = [];
  List<String> verses = [], versesLike = [], versesDraft = [];

  List<ListedExt>? listedSongs = [];
  List<Listed>? listeds = [];
  List<Draft>? drafts = [];

  Book setBook = Book();
  Draft setDraft = Draft();
  SongExt setSong = SongExt();
  SongExt setLiked = SongExt();
  Listed setListed = Listed();

  TextEditingController? searchController = TextEditingController();
  TextEditingController? titleController, contentController;
  PageType setPage = PageType.search;

  List<PageType> pages = [
    PageType.lists,
    PageType.search,
    PageType.likes,
    PageType.drafts,
    //PageType.helpdesk,
    //PageType.settings,
  ];
  Future<void> init(HomeNavigator screenNavigator) async {
    navigator = screenNavigator;

    titleController = TextEditingController();
    contentController = TextEditingController();
    shownUpdateHint = localStorage.getPrefBool(currentUpdate);

    await fetchData();
    isLoggedIn = localStorage.getPrefBool(PrefConstants.isLoggedIn);
    timeInstalled = localStorage.getPrefString(PrefConstants.dateInstalledKey);
    var dateValue = DateTime.parse(timeInstalled);
    dateDiff = DateTime.now().difference(dateValue).inDays;
    
    /*if (!shownUpdateHint) {
      var result = await FlutterPlatformAlert.showCustomAlert(
        windowTitle: tr!.hintsCurrentUpdate,
        text: tr!.hintsCurrentUpdateText,
        iconStyle: IconStyle.information,
        //neutralButtonTitle: tr!.donate,
        positiveButtonTitle: tr!.okay,
      );
      if (result == CustomButton.neutralButton) {
        localStorage.setPrefBool(currentUpdate, true);
        navigator.goToDonation();
      }
      if (result == CustomButton.positiveButton) {
        localStorage.setPrefBool(currentUpdate, true);
      }
    }*/
  }

  void setCurrentPage(PageType page) async {
    setPage = page;
    searchController!.clear();
    notifyListeners();
  }

  /// Get the data from the DB
  Future<void> fetchData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();

    books = await dbRepo.fetchBooks();
    songs = await dbRepo.fetchSongs();
    likes = await dbRepo.fetchLikedSongs();
    listeds = await dbRepo.fetchListeds();
    drafts = await dbRepo.fetchDrafts();
    await selectSongbook(books![0]);

    isBusy = false;
    notifyListeners();
  }

  void chooseListed(Listed listed) {
    localStorage.listed = setListed = listed;
    fetchListedSongs();
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
    listeds = await dbRepo.fetchListeds();
    setListed = listeds![0];
    isBusy = false;
    notifyListeners();
  }

  /// Get the data from the DB
  Future<void> fetchListedSongs() async {
    isMiniLoading = true;
    notifyListeners();

    listedSongs = await dbRepo.fetchListedSongs(setListed.id!);
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

  /// Get the song data from the DB
  Future<void> fetchSearchData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();
    books = await dbRepo.fetchBooks();
    songs = await dbRepo.fetchSongs();
    await selectSongbook(books![0]);
    isBusy = false;
    notifyListeners();
  }

  /// Get the notes data from the DB
  Future<void> fetchDraftsData({bool showLoading = true}) async {
    if (showLoading) isBusy = true;
    notifyListeners();
    drafts = await dbRepo.fetchDrafts();
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
      likes = await dbRepo.fetchLikedSongs();
      setLiked = likes![0];
    } catch (exception) {}

    isBusy = false;
    notifyListeners();
  }

  /// Add a song to liked songs
  Future<void> likeSongx(SongExt song) async {
    bool isLiked = song.liked!;
    isLiked = !isLiked;
    song.liked = isLiked;
    await dbRepo.editSong(song);
    await fetchLikedSongs(showLoading: false);
    if (isLiked) {
      showToast(
        text: '${song.title} ${tr!.songLiked}',
        state: ToastStates.success,
      );
    }
    notifyListeners();
  }

  /// Add a song to liked songs
  Future<void> likeSong(SongExt song) async {
    bool isLiked = false;
    isLiked = !isLiked;
    song.liked = isLiked;
    await dbRepo.editSong(song);
    likes = await dbRepo.fetchLikedSongs();
    if (setSong.liked!) {
      showToast(
        text: '${song.title} ${tr!.songLiked}',
        state: ToastStates.success,
      );
    }
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

  void onClear() async {
    filtered = songs;
    searchController!.clear();
    notifyListeners();
  }

  /// Save changes for a listed be it a new one or simply updating an old one
  Future<void> saveListChanges() async {
    if (titleController!.text.isNotEmpty) {
      isBusy = true;
      notifyListeners();
      setListed.title = titleController!.text;
      setListed.description = contentController!.text;
      await dbRepo.editListed(setListed);
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
      dbRepo.removeListed(listed.id!);
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

    await dbRepo.saveListedSong(setListed, song);
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
      await dbRepo.saveListed(listed);
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
  void rebuild() async {
    notifyListeners();
  }
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
