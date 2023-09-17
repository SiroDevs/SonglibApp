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

  Future<Response> fetchBooks();
  Future<Response> fetchSongs(String books);
}

class WebRepo implements WebRepository {
  final LocalStorage localStorage;
  final BookWebService bookApi;
  final SongWebService songApi;

  WebRepo(this.localStorage, this.bookApi, this.songApi);

  @override
  Future<Response> fetchBooks() async => await bookApi.fetchBooks();

  @override
  Future<Response> fetchSongs(String books) async =>
      await songApi.fetchSongs(books);
}
