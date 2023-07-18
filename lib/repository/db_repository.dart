import 'package:injectable/injectable.dart';

import '../db/dao/book_dao.dart';
import '../db/dao/draft_dao.dart';
import '../db/dao/edit_dao.dart';
import '../db/dao/history_dao.dart';
import '../db/dao/listed_dao.dart';
import '../db/dao/search_dao.dart';
import '../db/dao/song_dao.dart';
import '../models/base/book.dart';
import '../models/base/draft.dart';
import '../models/base/edit.dart';
import '../models/base/history.dart';
import '../models/base/historyext.dart';
import '../models/base/listed.dart';
import '../models/base/listedext.dart';
import '../models/base/search.dart';
import '../models/base/song.dart';
import '../models/base/songext.dart';

@lazySingleton
abstract class DbRepository {
  @factoryMethod
  factory DbRepository(
    BookDao bookDao,
    DraftDao draftDao,
    EditDao editDao,
    HistoryDao historyDao,
    ListedDao listedDao,
    SearchDao searchDao,
    SongDao songDao,
  ) = DbRepo;

  Future<List<Book>> fetchBooks();
  Future<List<Draft>> fetchDrafts();
  Future<List<HistoryExt>> fetchHistories();
  Future<List<Listed>> fetchListeds();
  Future<List<ListedExt>> fetchListedSongs(int listed);
  Future<List<Search>> fetchSearches();
  Future<List<SongExt>> fetchSongs();
  Future<List<SongExt>> fetchLikedSongs();
  Future<List<Edit>> fetchEdits();

  Future<void> saveBook(Book book);
  Future<void> saveSong(Song song);
  Future<void> saveDraft(Draft draft);
  Future<int> saveListed(Listed listed);
  Future<void> saveListedSong(Listed listed, SongExt song);
  Future<void> saveHistory(History history);
  Future<void> saveEdit(Edit edit);

  Future<void> editSong(SongExt song);
  Future<void> editDraft(Draft draft);
  Future<void> editListed(Listed listed);

  Future<void> removeBooks();
  Future<void> removeDraft(Draft draft);
  Future<void> removeEdit(Edit edit);
  Future<void> removeListed(Listed listed);
  Future<void> removeListedSongs(Listed listed);
  Future<void> majorCleanUp(String selectedBooks);
}

class DbRepo implements DbRepository {
  final BookDao bookDao;
  final DraftDao draftDao;
  final EditDao editDao;
  final HistoryDao historyDao;
  final ListedDao listedDao;
  final SearchDao searchDao;
  final SongDao songDao;

  DbRepo(
    this.bookDao,
    this.draftDao,
    this.editDao,
    this.historyDao,
    this.listedDao,
    this.searchDao,
    this.songDao,
  );

  @override
  Future<List<Book>> fetchBooks() async {
    return await bookDao.getAllBooks();
  }

  @override
  Future<List<Draft>> fetchDrafts() async {
    return await draftDao.getAllDrafts();
  }

  @override
  Future<List<HistoryExt>> fetchHistories() async {
    return await historyDao.getAllHistories();
  }

  @override
  Future<List<Listed>> fetchListeds() async {
    return await listedDao.getAllListeds();
  }

  @override
  Future<List<ListedExt>> fetchListedSongs(int parentid) async {
    return await listedDao.getListedSongs(parentid);
  }

  @override
  Future<List<Search>> fetchSearches() async {
    return await searchDao.getAllSearches();
  }

  @override
  Future<List<SongExt>> fetchSongs() async {
    return await songDao.getAllSongs();
  }

  @override
  Future<List<Edit>> fetchEdits() async {
    return await editDao.getAllEdits();
  }

  @override
  Future<List<SongExt>> fetchLikedSongs() async {
    return await songDao.getLikedSongs();
  }

  @override
  Future<void> saveBook(Book book) async {
    await bookDao.createBook(book);
  }

  @override
  Future<void> saveSong(Song song) async {
    await songDao.createSong(song);
  }

  @override
  Future<void> saveDraft(Draft draft) async {
    await draftDao.createDraft(draft: draft, isSimple: true);
  }

  @override
  Future<int> saveListed(Listed listed) async {
    return await listedDao.createListed(listed);
  }

  @override
  Future<void> saveEdit(Edit edit) async {
    await editDao.createEdit(edit);
  }

  @override
  Future<void> saveListedSong(Listed listed, SongExt song) async {
    await listedDao.updateListed(listed);
    return await listedDao.createListedSong(listed, song);
  }

  @override
  Future<void> saveHistory(History history) async {
    return await historyDao.createHistory(history);
  }

  @override
  Future<void> editSong(SongExt song) async {
    await editDao.createEdit(
      Edit(
        song: song.objectId,
        book: song.book,
        songNo: song.songNo,
        title: song.title,
        content: song.content,
        key: song.key,
        alias: song.alias,
      ),
    );
    await songDao.updateSong(song);
  }

  @override
  Future<void> editDraft(Draft draft) async {
    await draftDao.updateDraft(draft);
  }

  @override
  Future<void> editListed(Listed listed) async {
    await listedDao.updateListed(listed);
  }

  @override
  Future<void> removeBooks() async {
    await bookDao.deleteBooks();
  }

  @override
  Future<void> removeDraft(Draft draft) async {
    await draftDao.deleteDraft(draft);
  }

  @override
  Future<void> removeEdit(Edit edit) async {
    await editDao.deleteEdit(edit);
  }

  @override
  Future<void> removeListed(Listed listed) async {
    await listedDao.deleteListed(listed);
  }

  @override
  Future<void> removeListedSongs(Listed listed) async {
    await listedDao.deleteListedSongs(listed);
  }

  @override
  Future<void> majorCleanUp(String selectedBooks) async {
    final List<String> books = selectedBooks.split(",");
    final List<SongExt> songs = await songDao.getAllSongs();
    final List<History> histories = await historyDao.getHistories();
    final List<Listed> listeds = await listedDao.getAllListeds();
    //final List<Edit> edits = await editDao.getAllEdits();
    for (final song in songs) {
      if (!books.contains(song.book.toString())) {
        for (final history in histories) {
          if (history.song == song.id) await historyDao.deleteHistory(history);
        }
        for (final listed in listeds) {
          if (listed.song == song.id) await listedDao.deleteListed(listed);
        }
        await songDao.deleteSong(song);
      }
    }
  }
}
