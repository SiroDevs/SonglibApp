import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../webservice/book_web_service.dart';
import '../webservice/song_web_service.dart';
import 'local_storage.dart';

@lazySingleton
abstract class WebRepository {
  @factoryMethod
  factory WebRepository(
    LocalStorage localStorage,
    BookWebService bookService,
    SongWebService songService,
  ) = WebRepo;

  Future<Response> getBooksList();
  Future<Response> getSongsByBook(String booksId);
}

class WebRepo implements WebRepository {
  final LocalStorage localStorage;
  final BookWebService bookApi;
  final SongWebService songApi;

  WebRepo(
    this.localStorage,
    this.bookApi,
    this.songApi,
  );

  @override
  Future<Response> getBooksList() async => await bookApi.getBooksList();
  
  @override
  Future<Response> getSongsByBook(String bookApi) async =>
      await songApi.getSongsByBook(bookApi);
}
