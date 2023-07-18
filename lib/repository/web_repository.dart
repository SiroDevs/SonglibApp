import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../models/base/song.dart';
import '../webservice/song_web_service.dart';
import 'shared_prefs/local_storage.dart';

@lazySingleton
abstract class WebRepository {
  @factoryMethod
  factory WebRepository(
    LocalStorage localStorage,
    SongWebService songService,
  ) = WebRepo;

  Future<Response> newSong(Song song);
  Future<Response> editSong(Song song);
  Future<Response> fetchSongs();
  Future<Response> fetchSong(int songId);
  Future<Response> fetchSongsByBook(String bookIds);
  Future<Response> deleteSong(int songId);
}

class WebRepo implements WebRepository {
  final LocalStorage localStorage;
  final SongWebService songApi;

  WebRepo(this.localStorage, this.songApi);

  @override
  Future<Response> deleteSong(int songId) async =>
      await songApi.deleteSong(songId);

  @override
  Future<Response> editSong(Song song) {
    // TODO: implement editSong
    throw UnimplementedError();
  }

  @override
  Future<Response> fetchSong(int songId) {
    // TODO: implement fetchSong
    throw UnimplementedError();
  }

  @override
  Future<Response> fetchSongs() {
    // TODO: implement fetchSongs
    throw UnimplementedError();
  }

  @override
  Future<Response> fetchSongsByBook(String bookIds) {
    // TODO: implement fetchSongsByBook
    throw UnimplementedError();
  }

  @override
  Future<Response> newSong(Song song) {
    // TODO: implement newSong
    throw UnimplementedError();
  }
}
