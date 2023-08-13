import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../utils/constants/api_constants.dart';
import '../utils/utilities.dart';

@lazySingleton
abstract class BookWebService {
  @factoryMethod
  factory BookWebService() = BookService;

  Future<Response> getBooksList();
}

class BookService implements BookWebService {
  @override
  Future<Response> getBooksList() async {
    return makeApiGetRequest(
      ApiConstants.book,
      {'Content-Type': 'application/json'},
    );
  }
}
