import 'dart:developer' as logger show log;
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/book.dart';
import '../../model/tables/books_table.dart';
import '../app_database.dart';

part 'book_dao.g.dart';

@lazySingleton
abstract class BookDao {
  @factoryMethod
  factory BookDao(AppDatabase db) = _BookDao;

  Future<void> checkBooks();
  Future<List<Book>> getAllBooks();
  Future<int> createBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(int id);
  Future<void> deleteBooks();
  Future<void> dropBooksTable();
}

@DriftAccessor(tables: [
  BooksTable,
])
class _BookDao extends DatabaseAccessor<AppDatabase>
    with _$_BookDaoMixin
    implements BookDao {
  _BookDao(AppDatabase db) : super(db);

  @override
  Future<void> checkBooks() async {
    logger.log('Checking for if book tables exists as expected');
    try {
      String sqlQry =
          'SELECT * FROM ${db.booksTable.actualTableName} ORDER BY ${db.booksTable.position.name} ASC;';
      logger.log('Select Query: $sqlQry');
      await customSelect(sqlQry).watch().first;
      logger.log('${db.booksTable.actualTableName} table exists as expected');
    } catch (e) {
      logger.log('Query Error: $e');
      try {
        String sqlQry =
            'ALTER TABLE db_book_table RENAME TO ${db.booksTable.actualTableName};';
        logger.log('Alter Query: $sqlQry');
        await customStatement(sqlQry);
        logger.log(
            'db_book_table renamed to ${db.booksTable.actualTableName} successfully');
      } catch (e) {
        logger.log('Query Error: $e');
      }
    }
  }

  @override
  Future<List<Book>> getAllBooks() async {
    List<Book> items = [];
    String sqlQry =
        'SELECT * FROM ${db.booksTable.actualTableName} ORDER BY ${db.booksTable.position.name} ASC;';
    logger.log('Select Query: $sqlQry');
    try {
      items = await customSelect(sqlQry).watch().map(
        (rows) {
          return rows.map((row) => Book.fromData(row.data)).toList();
        },
      ).first;
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return items;
  }

  @override
  Future<int> createBook(Book book) async {
    int result = 0;
    String sqlQry = "INSERT INTO ${db.booksTable.actualTableName} "
        "(${db.booksTable.bookId.name}, ${db.booksTable.bookNo.name}, ${db.booksTable.enabled.name}, ${db.booksTable.title.name}, "
        "${db.booksTable.subTitle.name}, ${db.booksTable.songs.name}, ${db.booksTable.position.name}, ${db.booksTable.created.name}, ${db.booksTable.updated.name}) "
        "VALUES (${book.bookId}, ${book.bookNo}, ${book.enabled}, ${book.title}, ${book.subTitle}, ${book.songs}, ${book.position}, ${book.created}, ${book.updated});";
    logger.log('Insert Query: $sqlQry');
    try {
      final sqlStatement = BooksTableCompanion.insert(
        bookId: Value(book.bookId ?? 0),
        bookNo: Value(book.bookNo ?? 0),
        enabled: Value(book.enabled ?? false),
        title: Value(book.title ?? ''),
        subTitle: Value(book.subTitle ?? ''),
        songs: Value(book.songs ?? 0),
        position: Value(book.position ?? 0),
        created: Value(book.created ?? ''),
        updated: Value(book.updated ?? ''),
      );
      result = await into(db.booksTable).insert(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }
    return result;
  }

  @override
  Future<int> updateBook(Book book) async {
    int result = 0;
    String sqlQry = "UPDATE ${db.booksTable.actualTableName} "
        "SET (${db.booksTable.bookId.name} = ${book.bookId}, ${db.booksTable.bookNo.name} = ${book.bookNo}, ${db.booksTable.enabled.name} = ${book.enabled}, "
        "${db.booksTable.title.name} = ${book.title}, ${db.booksTable.subTitle.name} = ${book.subTitle}, ${db.booksTable.songs.name} = ${book.songs}, "
        "${db.booksTable.position.name} = ${book.position}, ${db.booksTable.updated.name} = ${book.updated}) "
        "WHERE ${db.booksTable.id.name} = ${book.id};";
    logger.log('Update Query: $sqlQry');
    try {
      final sqlStatement = BooksTableCompanion(
        bookId: Value(book.bookId!),
        bookNo: Value(book.bookNo!),
        enabled: Value(book.enabled!),
        title: Value(book.title!),
        subTitle: Value(book.subTitle!),
        songs: Value(book.songs!),
        position: Value(book.position!),
        updated: Value(book.updated!),
      );
      await (update(db.booksTable)..where((row) => row.id.equals(book.id)))
          .write(sqlStatement);
    } catch (e) {
      logger.log('Query Error: $e');
    }

    return result;
  }

  @override
  Future<void> deleteBook(int id) async {
    try {
      String sqlQry =
          'DELETE FROM ${db.booksTable.actualTableName} WHERE ${db.booksTable.id.name} = $id;';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.booksTable)..where((row) => row.id.equals(id))).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> deleteBooks() async {
    try {
      String sqlQry = 'DELETE FROM ${db.booksTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.booksTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }

  @override
  Future<void> dropBooksTable() async {
    try {
      String sqlQry = 'DROP TABLE ${db.booksTable.actualTableName};';
      logger.log('Delete Query: $sqlQry');
      await (delete(db.booksTable)).go();
    } catch (e) {
      logger.log('Query Error: $e');
    }
  }
}
