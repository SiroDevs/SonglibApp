import 'dart:async';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../utils/constants/api_constants.dart';
import '../utils/app_utils.dart';

@lazySingleton
abstract class BookWebService {
  @factoryMethod
  factory BookWebService() = BookService;

  Future<Response> fetchBooks();
}

class BookService implements BookWebService {
  @override
  Future<Response> fetchBooks() async {
    return makeApiGetRequest(
      ApiConstants.book,
      {
        'Content-Type': 'application/json',
      },
    );
  }
}
