import 'package:drift/drift.dart';
import 'dart:developer' as logger show log;
import 'package:injectable/injectable.dart';

import '../app_database.dart';

@lazySingleton
abstract class AppDao {
  @factoryMethod
  factory AppDao(AppDatabase db) = _AppDao;

  Future<void> checkAppDatabase();
}

class _AppDao extends DatabaseAccessor<AppDatabase> implements AppDao {
  _AppDao(AppDatabase db) : super(db);

  /// Check if App Database exists as new configuration
  @override
  Future<void> checkAppDatabase() async {
    logger.log('Checking for if tables exists as expected');

    await checkBooks();
    await checkDrafts();
    await checkEdits();
    await checkHistorys();
    await checkListeds();
    await checkSearchs();
    await checkSongs();

    logger.log('Done checking for if tables exists as expected');
  }

  /// Check if Books Table exists
  Future<void> checkBooks() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.booksTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.booksTable.actualTableName};',
      ).watch().first;
      logger.log('${db.booksTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_book_table RENAME TO ${db.booksTable.actualTableName};',
        );
        logger.log(
          '"db_book_table" renamed to "${db.booksTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.booksTable.actualTableName} ADD ${db.booksTable.bookId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.booksTable.bookId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.booksTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.booksTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.booksTable.actualTableName}" table renamed to "created" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.booksTable.actualTableName} RENAME COLUMN updated_at TO updated;',
        );
        logger.log(
          'Column "updated" in "${db.booksTable.actualTableName}" table renamed to "updated" successfully',
        );
        checkBooks();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Drafts Table exists
  Future<void> checkDrafts() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.draftsTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.draftsTable.actualTableName};',
      ).watch().first;
      logger.log('${db.draftsTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_draft_table RENAME TO ${db.draftsTable.actualTableName};',
        );
        logger.log(
          '"db_draft_table" renamed to "${db.draftsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.draftsTable.actualTableName} ADD ${db.draftsTable.draftId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.draftsTable.draftId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.draftsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.draftsTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.draftsTable.actualTableName}" table renamed to "created" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.draftsTable.actualTableName} RENAME COLUMN updated_at TO updated;',
        );
        logger.log(
          'Column "updated" in "${db.draftsTable.actualTableName}" table renamed to "updated" successfully',
        );
        checkDrafts();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Edits Table exists
  Future<void> checkEdits() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.editsTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.editsTable.actualTableName};',
      ).watch().first;
      logger.log('${db.editsTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_edit_table RENAME TO ${db.editsTable.actualTableName};',
        );
        logger.log(
          '"db_edit_table" renamed to "${db.editsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.editsTable.actualTableName} ADD ${db.editsTable.editId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.editsTable.editId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.editsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.editsTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.editsTable.actualTableName}" table renamed to "created" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.editsTable.actualTableName} ADD ${db.editsTable.created.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.editsTable.editId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.editsTable.actualTableName}" successfully',
        );
        checkEdits();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Historys Table exists
  Future<void> checkHistorys() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.historysTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.historysTable.actualTableName};',
      ).watch().first;
      logger.log('${db.historysTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_history_table RENAME TO ${db.historysTable.actualTableName};',
        );
        logger.log(
          '"db_history_table" renamed to "${db.historysTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.historysTable.actualTableName} ADD ${db.historysTable.historyId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.historysTable.historyId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.historysTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.historysTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.historysTable.actualTableName}" table renamed to "created" successfully',
        );
        checkHistorys();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Listeds Table exists
  Future<void> checkListeds() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.listedsTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.listedsTable.actualTableName};',
      ).watch().first;
      logger.log('${db.listedsTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_listed_table RENAME TO ${db.listedsTable.actualTableName};',
        );
        logger.log(
          '"db_listed_table" renamed to "${db.listedsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.listedsTable.actualTableName} ADD ${db.listedsTable.listedId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.listedsTable.listedId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.listedsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.listedsTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.listedsTable.actualTableName}" table renamed to "created" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.listedsTable.actualTableName} RENAME COLUMN updated_at TO updated;',
        );
        logger.log(
          'Column "updated" in "${db.listedsTable.actualTableName}" table renamed to "updated" successfully',
        );
        checkListeds();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Searchs Table exists
  Future<void> checkSearchs() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.searchsTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.searchsTable.actualTableName};',
      ).watch().first;
      logger.log('${db.searchsTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_search_table RENAME TO ${db.searchsTable.actualTableName};',
        );
        logger.log(
          '"db_search_table" renamed to "${db.searchsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.searchsTable.actualTableName} ADD ${db.searchsTable.searchId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.searchsTable.searchId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.searchsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.searchsTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.searchsTable.actualTableName}" table renamed to "created" successfully',
        );
        checkSearchs();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }

  /// Check if Songs Table exists
  Future<void> checkSongs() async {
    logger.log('* * * * * * * * * * *');
    logger.log('Checking if ${db.songsTable.actualTableName} table exists');
    try {
      await customSelect(
        'SELECT * FROM ${db.songsTable.actualTableName};',
      ).watch().first;
      logger.log('${db.songsTable.actualTableName} table checked');
    } catch (e) {
      logger.log(e.toString());
      try {
        await customStatement(
          'ALTER TABLE db_song_table RENAME TO ${db.songsTable.actualTableName};',
        );
        logger.log(
          '"db_song_table" renamed to "${db.songsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.songsTable.actualTableName} ADD ${db.songsTable.songId.name} INTEGER NOT NULL DEFAULT 0;',
        );
        logger.log(
          'Column "${db.songsTable.songId.name} INTEGER NOT NULL DEFAULT 0", added to "${db.songsTable.actualTableName}" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.songsTable.actualTableName} RENAME COLUMN created_at TO created;',
        );
        logger.log(
          'Column "created" in "${db.songsTable.actualTableName}" table renamed to "created" successfully',
        );
        await customStatement(
          'ALTER TABLE ${db.songsTable.actualTableName} RENAME COLUMN updated_at TO updated;',
        );
        logger.log(
          'Column "updated" in "${db.songsTable.actualTableName}" table renamed to "updated" successfully',
        );
        checkSongs();
      } catch (e) {
        logger.log(e.toString());
      }
    }
  }
}
