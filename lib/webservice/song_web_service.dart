import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../utils/constants/api_constants.dart';
import '../utils/utilities.dart';

@lazySingleton
abstract class SongWebService {
  @factoryMethod
  factory SongWebService() = SongService;

  Future<Response> getSongsByBook(String booksId);
}

class SongService implements SongWebService {
  @override
  Future<Response> getSongsByBook(booksId) async {
    return makeApiGetRequest(
      '${ApiConstants.songByBook}/$booksId',
      {'Content-Type': 'application/json'},
    );
  }
}
