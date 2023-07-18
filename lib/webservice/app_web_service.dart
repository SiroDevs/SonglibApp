import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../utils/constants/api_constants.dart';
import '../models/responses/parse_resp.dart';
import '../utils/constants/event_constants.dart';

@lazySingleton
abstract class AppWebService {
  @factoryMethod
  factory AppWebService() = AppService;

  Future<ParseResp> fetchBooks();
  Future<ParseResp> fetchEdits(List<int> books);
  Future<ParseResp> fetchSongs(List<int> books);
}

class AppService implements AppWebService {
  @override
  Future<ParseResp> fetchBooks() async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject(ApiConstants.book));
      parseQuery
        ..whereEqualTo('enabled', true)
        ..orderByAscending('position');
      final ParseResponse apiResponse = await parseQuery.query();

      if (apiResponse.success && apiResponse.results != null) {
        // ignore: avoid_print
        print('Api Request: ${ApiConstants.parseApiBaseUrl}${ApiConstants.book}');
        // ignore: avoid_print
        print('Api Response: [${apiResponse.statusCode}] ${apiResponse.results}');
        return ParseResp(
          apiResponse.results as List<ParseObject>,
          id: EventConstants.requestSuccessful,
        );
      } else {
        return ParseResp([], id: EventConstants.requestUnsuccessful);
      }
    } on TimeoutException catch (_) {
      return ParseResp([], id: EventConstants.requestTimeout);
    } on Exception {
      return ParseResp([], id: EventConstants.requestUnsuccessful);
    }
  }

  @override
  Future<ParseResp> fetchEdits(List<int> books) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject(ApiConstants.song));
      parseQuery
        ..whereContainedIn('book', books)
        ..orderByAscending('songNo')
        ..setLimit(10000);
      final ParseResponse apiResponse = await parseQuery.query();

      if (apiResponse.success && apiResponse.results != null) {
        // ignore: avoid_print
        print('Api Request: ${ApiConstants.parseApiBaseUrl}${ApiConstants.song}');
        // ignore: avoid_print
        print('Api Response: [${apiResponse.statusCode}] ${apiResponse.results}');
        return ParseResp(
          apiResponse.results as List<ParseObject>,
          id: EventConstants.requestSuccessful,
        );
      } else {
        return ParseResp([], id: EventConstants.requestUnsuccessful);
      }
    } on TimeoutException catch (_) {
      return ParseResp([], id: EventConstants.requestTimeout);
    } on Exception {
      return ParseResp([], id: EventConstants.requestUnsuccessful);
    }
  }

  @override
  Future<ParseResp> fetchSongs(List<int> books) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject(ApiConstants.song));
      parseQuery
        ..whereContainedIn('book', books)
        ..orderByAscending('songNo')
        ..setLimit(10000);
      final ParseResponse apiResponse = await parseQuery.query();

      if (apiResponse.success && apiResponse.results != null) {
        // ignore: avoid_print
        print('Api Request: ${ApiConstants.parseApiBaseUrl}${ApiConstants.song}');
        // ignore: avoid_print
        print('Api Response: [${apiResponse.statusCode}] ${apiResponse.results}');
        return ParseResp(
          apiResponse.results as List<ParseObject>,
          id: EventConstants.requestSuccessful,
        );
      } else {
        return ParseResp([], id: EventConstants.requestUnsuccessful);
      }
    } on TimeoutException catch (_) {
      return ParseResp([], id: EventConstants.requestTimeout);
    } on Exception {
      return ParseResp([], id: EventConstants.requestUnsuccessful);
    }
  }
}
