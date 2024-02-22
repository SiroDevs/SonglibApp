import 'package:injectable/injectable.dart';

import '../data/db/dao/book_dao.dart';
import '../data/models/book.dart';

@lazySingleton
abstract class DbRepository {
  @factoryMethod
  factory DbRepository(
    BookDao bookDao,
  ) = DbRepo;

  Future<List<Book>> fetchBooks();
}

class DbRepo implements DbRepository {
  final BookDao bookDao;

  DbRepo(
    this.bookDao,
  );

  @override
  Future<List<Book>> fetchBooks() async => await bookDao.getAllBooks();
}
