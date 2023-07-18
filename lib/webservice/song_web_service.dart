import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../models/base/song.dart';
import '../utils/constants/api_constants.dart';
import '../utils/http_utils.dart';

@lazySingleton
abstract class SongWebService {
  @factoryMethod
  factory SongWebService() = SongService;

  Future<Response> newSong(Song song);
  Future<Response> editSong(Song song);
  Future<Response> fetchSongs();
  Future<Response> fetchSong(int songId);
  Future<Response> fetchSongsByBook(String bookIds);
  Future<Response> deleteSong(int songId);
}

class SongService implements SongWebService {
  @override
  Future<Response> newSong(song) async {
    return postRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songs}',
      {'Content-Type': 'application/json'},
      {
        "book": song.book,
        "alias": song.alias,
        "songNo": song.songNo,
        "title": song.title,
        "content": song.content
      },
    );
  }

  @override
  Future<Response> editSong(song) async {
    return postRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songs}',
      {'Content-Type': 'application/json'},
      {
        "book": song.book,
        "alias": song.alias,
        "songNo": song.songNo,
        "title": song.title,
        "content": song.content
      },
    );
  }

  @override
  Future<Response> fetchSongs() async {
    return getRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songs}',
      {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<Response> fetchSong(int songId) async {
    return getRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songs}/$songId',
      {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<Response> fetchSongsByBook(bookIds) async {
    return getRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songsByBook}$bookIds',
      {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<Response> deleteSong(songId) async {
    return deleteRequest(
      '${ApiConstants.baseUrl}${ApiConstants.songs}/$songId',
      {'Content-Type': 'application/json'},
    );
  }

}
