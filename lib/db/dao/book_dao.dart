import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/book.dart';
import '../../models/tables/db_book_table.dart';
import '../songlib_db.dart';

part 'book_dao.g.dart';

@lazySingleton
abstract class BookDao {
  @factoryMethod
  factory BookDao(SongLibDB db) = _BookDao;

  Future<List<Book>> getAllBooks();
  Future<void> createBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(Book book);
  Future<void> deleteBooks();
}

@DriftAccessor(tables: [
  DbBookTable,
])
class _BookDao extends DatabaseAccessor<SongLibDB>
    with _$_BookDaoMixin
    implements BookDao {
  _BookDao(SongLibDB db) : super(db);

  @override
  Future<List<Book>> getAllBooks() async {
    return await customSelect(
      'SELECT * FROM ${db.dbBookTable.actualTableName} '
      'ORDER BY ${db.dbBookTable.position.name} ASC;',
      readsFrom: {db.dbBookTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => Book.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<void> createBook(Book book) => into(db.dbBookTable).insert(
        DbBookTableCompanion.insert(
          objectId: book.objectId!,
          bookNo: Value(book.bookNo!),
          enabled: Value(book.enabled!),
          title: Value(book.title!),
          subTitle: Value(book.subTitle!),
          songs: Value(book.songs!),
          position: Value(book.position!),
          createdAt: Value(book.createdAt!),
          updatedAt: Value(book.updatedAt!),
        ),
      );

  @override
  Future<void> updateBook(Book book) =>
      (update(db.dbBookTable)..where((row) => row.id.equals(book.id!))).write(
        DbBookTableCompanion(
          bookNo: Value(book.bookNo!),
          enabled: Value(book.enabled!),
          title: Value(book.title!),
          subTitle: Value(book.subTitle!),
          songs: Value(book.songs!),
          position: Value(book.position!),
          updatedAt: Value(book.updatedAt!),
        ),
      );

  @override
  Future<void> deleteBook(Book book) =>
      (delete(db.dbBookTable)..where((row) => row.id.equals(book.id!))).go();

  @override
  Future<void> deleteBooks() => (delete(db.dbBookTable)).go();
}
