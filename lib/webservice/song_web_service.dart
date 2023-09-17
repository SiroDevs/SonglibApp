import 'dart:async';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../utils/constants/api_constants.dart';
import '../utils/utilities.dart';

@lazySingleton
abstract class SongWebService {
  @factoryMethod
  factory SongWebService() = SongService;

  Future<Response> fetchSongs(String books);
}

class SongService implements SongWebService {
  
  @override
  Future<Response> fetchSongs(String books) async {
    return makeApiGetRequest(
      '${ApiConstants.songByBook}$books',
      {
        'Content-Type': 'application/json',
      },
    );
  }

}
