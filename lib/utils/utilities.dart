import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger show log;

import '../model/base/songext.dart';
import 'constants/api_constants.dart';

bool isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;

String dateNow() {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
}

String dateToString(DateTime dateValue) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateValue);
}

Future<bool> isKeyboardShowing() async {
  // ignore: unnecessary_null_comparison
  if (WidgetsBinding.instance != null) {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  } else {
    return false;
  }
}

Future<void> closeKeyboard(BuildContext context) async {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

String? textValidator(String? value) {
  if (value!.isEmpty) {
    return 'This field is required';
  }
  return null;
}

bool isNumeric(String s) {
  // ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String truncateString(int cutoff, String myString) {
  var words = myString.split(' ');
  try {
    if (myString.length > cutoff) {
      if ((myString.length - words[words.length - 1].length) < cutoff) {
        return myString.replaceAll(words[words.length - 1], '');
      } else {
        return (myString.length <= cutoff)
            ? myString
            : myString.substring(0, cutoff);
      }
    } else {
      return myString.trim();
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
    return myString.trim();
  }
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

String refineTitle(String textTitle) {
  return textTitle.replaceAll("''", "'");
}

String refineContent(String contentText) {
  return contentText.replaceAll("''", "'").replaceAll("#", " ");
}

String songItemTitle(int number, String title) {
  if (number != 0) {
    return "$number. ${refineTitle(title)}";
  } else {
    return refineTitle(title);
  }
}

List<String> songVerses(String songContent) {
  List<String> verseList = [];
  var verses = songContent.split("##");

  for (final verse in verses) {
    verseList.add(verse.replaceAll("#", "\n"));
  }
  return verseList;
}

String songCopyString(String title, String content) {
  return "$title\n\n$content";
}

String bookCountString(String title, int count) {
  return '$title ($count)';
}

String lyricsString(String lyrics) {
  return lyrics.replaceAll("#", "\n").replaceAll("''", "'");
}

String songViewerTitle(int number, String title, String alias) {
  String songtitle = "$number. ${refineTitle(title)}";

  if (alias.length > 2 && title != alias) {
    songtitle = "$songtitle (${refineTitle(alias)})";
  }

  return songtitle;
}

String songShareString(String title, String content) {
  return "$title\n\n$content\n\nvia #vSongBook https://Appsmata.com/vSongBook";
}

String verseOfString(String number, int count) {
  return 'VERSE $number of $count';
}

double getFontSize(int characters, double height, double width) {
  return sqrt((height * width) / characters);
}

List<SongExt> seachSongByQuery(String query, List<SongExt> songs) {
  List<SongExt> filtered = [];
  final qry = query.toLowerCase();

  filtered = songs.where((s) {
    // Check if the song number matches the query (if query is numeric)
    if (isNumeric(query) && s.songNo == int.parse(query)) {
      return true;
    }

    // Create a regular expression pattern to match "," and "!" characters
    RegExp charsPtn = RegExp(r'[!,]');

    // Split the query into words if it contains commas
    List<String> words;
    if (query.contains(',')) {
      words = query.split(',');
      // Trim whitespace from each word
      words = words.map((w) => w.trim()).toList();
    } else {
      words = [qry];
    }

    // Create a regular expression pattern to match the words in the query
    RegExp queryPtn = RegExp(words.map((w) => '($w)').join('.*'));

    // Remove "," and "!" characters from s.title, s.alias, and s.content
    String title = s.title!.replaceAll(charsPtn, '').toLowerCase();
    //String alias = s.alias!.replaceAll(charsPtn, '').toLowerCase();
    String content = s.content!.replaceAll(charsPtn, '').toLowerCase();

    // Check if the song title matches the query, ignoring "," and "!" characters
    if (queryPtn.hasMatch(title)) {
      return true;
    }

    // Check if the song alias matches the query, ignoring "," and "!" characters
    /*if (queryPtn.hasMatch(alias)) {
      return true;
    }*/

    // Check if the song content matches the query, ignoring "," and "!" characters
    if (queryPtn.hasMatch(content)) {
      return true;
    }

    return false;
  }).toList();

  return filtered;
}

Future<http.Response> makeApiPostRequest(
  String endpoint,
  Map<String, String> headers,
  dynamic requestBody,
) async {
  if (await isConnected()) {
    try {
      logger.log('Api Request: ${ApiConstants.baseUrl}$endpoint');
      logger.log('JsonData: ${json.encode(requestBody)}');

      final response = await http
          .post(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: headers,
        body: json.encode(requestBody),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          logger.log('Timeout occurred. Please try again later.');
          return http.Response('Timeout occurred', 504);
        },
      );

      logger.log('Api Response: [${response.statusCode}] ${response.body}');

      return response;
    } catch (e) {
      if (e is TimeoutException) {
        logger.log('Timeout occurred. Please try again later.');
        return http.Response('Timeout occurred', 504);
      } else {
        logger.log('An error occurred during the HTTP request: $e');
        return http.Response('Internal server error', 500);
      }
    }
  } else {
    logger.log('No internet connection. Please try again later.');
    return http.Response('No internet connection', 500);
  }
}

Future<http.Response> makeApiGetRequest(
  String endpoint,
  Map<String, String> headers,
) async {
  if (await isConnected()) {
    try {
      final response = await http
          .get(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'),
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          logger.log('Timeout occurred. Please try again later.');
          return http.Response('Timeout occurred', 504);
        },
      );

      logger.log('Api Request: ${ApiConstants.baseUrl}$endpoint');
      logger.log('Api Response: [${response.statusCode}] ${response.body}');

      return response;
    } catch (e) {
      if (e is TimeoutException) {
        logger.log('Timeout occurred. Please try again later.');
        return http.Response('Timeout occurred', 504);
      } else {
        logger.log('An error occurred during the HTTP request: $e');
        return http.Response('Internal server error', 500);
      }
    }
  } else {
    logger.log('No internet connection. Please try again later.');
    return http.Response('No internet connection', 500);
  }
}
