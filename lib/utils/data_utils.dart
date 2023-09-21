import 'dart:convert';
import 'dart:developer' as logger show log;
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../model/base/song.dart';
import '../model/base/songext.dart';
import '../repository/db_repository.dart';
import '../repository/web_repository.dart';
import '../widgets/general/toast.dart';
import 'app_utils.dart';

class DataUtils {
  DataUtils._();
  static Future<void> copySong(SongExt song) async {
    await Clipboard.setData(ClipboardData(
      text:
          '${songItemTitle(song.songNo!, song.title!)}\n${refineTitle(song.songbook!)}'
          '\n\n${song.content!.replaceAll("#", "\n")}',
    ));
    showToast(
      text: '${song.title} Copied', //${tr!.songCopied}',
      state: ToastStates.success,
    );
  }

  static Future<void> shareSong(SongExt song) async {
    await Share.share(
      '${songItemTitle(song.songNo!, song.title!)}\n${refineTitle(song.songbook!)}'
      '\n\n${song.content!.replaceAll("#", "\n")}',
      //subject: tr!.shareVerse,
    );
  }

  static Future<void> readAndParseJson(List<dynamic> args) async {
    SendPort resultPort = args[0];
    WebRepository api = args[1];
    String books = args[2];

    List<Song>? songs = [];
    var response = await api.fetchSongs(books);
    var resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> dataList = resp['data'];
      songs = dataList.map((item) => Song.fromJson(item)).toList();
      if (songs.isNotEmpty) {
        List<dynamic> dataList = resp['data'];
        songs = dataList.map((item) => Song.fromJson(item)).toList();
      }
    } else if (response.statusCode == 404) {
      logger.log('Fetching songs data failed with code 404');
    } else if (response.statusCode == 500) {
      logger.log(
          'Internal Server Error: Please check if you are behind a firewall before trying again');
    } else if (response.statusCode == 504) {
      logger.log(
          'Request Timeout: Please check if you are behind a firewall before trying again');
    } else {
      logger.log(resp['statusMessage']);
    }

    Isolate.exit(resultPort, songs);
  }

  static void fetchSongs({
    required WebRepository iApi,
    required DbRepository iDb,
    String? books,
  }) async {
    final resultPort = ReceivePort();

    await Isolate.spawn(
      readAndParseJson,
      [resultPort.sendPort, iApi, books],
    );
    List<Song> songs = [];
    songs = await (resultPort.first) as List<Song>;

    if (songs.isNotEmpty) {
      logger.log('Savings songs to the db');
      for (int i = 0; i < songs.length; i++) {
        iDb.saveSong(songs[i]);
      }
      logger.log('Songs saved to the db successfully');
    }
  }

  /// Get the list of songs from the api
  static Future<List<Song>> fetchSongss(
      {required WebRepository wmApi, String? books}) async {
    List<Song>? songs = [];
    var response = await wmApi.fetchSongs(books!);
    var resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> dataList = resp['data'];
      songs = dataList.map((item) => Song.fromJson(item)).toList();
      if (songs.isNotEmpty) {
        List<dynamic> dataList = resp['data'];
        songs = dataList.map((item) => Song.fromJson(item)).toList();
      }
    } else if (response.statusCode == 404) {
      logger.log('Fetching songs data failed with code 404');
    } else if (response.statusCode == 500) {
      logger.log(
          'Internal Server Error: Please check if you are behind a firewall before trying again');
    } else if (response.statusCode == 504) {
      logger.log(
          'Request Timeout: Please check if you are behind a firewall before trying again');
    } else {
      logger.log(resp['statusMessage']);
    }
    return songs;
  }

  static bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static List<SongExt> seachSongByQuery(String query, List<SongExt> songs) {
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
}
