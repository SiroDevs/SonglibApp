import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:developer' as logger show log;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import 'constants/api_constants.dart';

bool isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;

Future<void> saveFile(String path, Uint8List content) async {
  final file = File(path);
  await file.writeAsBytes(content);
}

String getShortPath(String path) {
  var f = p.split(path);
  if (f.length > 2) {
    f = f.sublist(f.length - 2);
    return ".../${p.joinAll(f)}";
  }
  return path;
}

// download directory
Future<String> downloadDir() async {
  String downloadsPath;

  if (Platform.isMacOS) {
    downloadsPath = '/Users/${Platform.environment['USER']}/Downloads';
  } else if (Platform.isWindows) {
    downloadsPath = '${Platform.environment['USERPROFILE']}\\Downloads';
  } else if (Platform.isLinux) {
    downloadsPath = '/home/${Platform.environment['USER']}/Downloads';
  } else if (Platform.isAndroid) {
    Directory directory = Directory('/storage/emulated/0/Download');
    downloadsPath = directory.path;
  } else {
    // Handle other platforms or fallback
    downloadsPath = 'Platform not supported';
  }
  return downloadsPath;
}

String dateNow() {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
}

String dateToString(DateTime dateValue) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateValue);
}

Future<bool> isKeyboardShowing(BuildContext context) async {
  // ignore: unnecessary_null_comparison
  if (WidgetsBinding.instance != null) {
    return View.of(context).viewInsets.bottom > 0;
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
    logger.log(e.toString());
    return myString.trim();
  }
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

String sanitizeResp(String str) {
  return str
      .replaceAll('_', ' ')
      .replaceAll('{"error":"', '')
      .replaceAll('"}', '')
      .camelCase();
}

extension StringExtension on String {
  String camelCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll('_', '')}";
  }
}

String getMonthNumber(String month) {
  switch (month) {
    case 'Jan':
      return '01';
    case 'Feb':
      return '02';
    case 'Mar':
      return '03';
    case 'Apr':
      return '04';
    case 'May':
      return '05';
    case 'Jun':
      return '06';
    case 'Jul':
      return '07';
    case 'Aug':
      return '08';
    case 'Sep':
      return '09';
    case 'Oct':
      return '10';
    case 'Nov':
      return '11';
    case 'Dec':
      return '12';
    default:
      return DateFormat('MM').format(DateTime.now());
  }
}

Future<http.Response> makeApiPostRequest(
  String endpoint,
  Map<String, String> headers,
  dynamic requestBody,
) async {
  try {
    logger.log('Api Request: $endpoint');
    logger.log('JsonData: ${json.encode(requestBody)}');

    final response = await http
        .post(
      Uri.parse('${ApiConstants.baseUrl}$endpoint'),
      headers: headers,
      body: json.encode(requestBody),
    )
        .timeout(
      const Duration(seconds: 30),
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
}

Future<http.Response> makeApiGetRequest(
  String endpoint,
  Map<String, String> headers,
) async {
  try {
    final response = await http
        .get(
      Uri.parse('${ApiConstants.baseUrl}$endpoint'),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        logger.log('Timeout occurred. Please try again later.');
        return http.Response('Timeout occurred', 504);
      },
    );

    logger.log('Api Request: $endpoint');
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
}
