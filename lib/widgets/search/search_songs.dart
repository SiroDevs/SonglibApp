import 'package:flutter/material.dart';

import '../../model/base/songext.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/home/home_vm.dart';
import '../general/list_items.dart';

/// Small screen search
class SearchSongs extends SearchDelegate<List> {
  final HomeVm vm;
  final double? height;

  SearchSongs(BuildContext context, this.vm, this.height);

  @override
  String get searchFieldLabel => "Search a Song";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: ThemeColors.primary),
      textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white)),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, vm.songs!),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => searchThis(context);

  @override
  Widget buildSuggestions(BuildContext context) => searchThis(context);

  Widget searchThis(BuildContext context) {
    final qry = query.toLowerCase();

    List<SongExt> matchQuery = vm.songs!.where((s) {
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
      String alias = s.alias!.replaceAll(charsPtn, '').toLowerCase();
      String content = s.content!.replaceAll(charsPtn, '').toLowerCase();

      // Check if the song title matches the query, ignoring "," and "!" characters
      if (queryPtn.hasMatch(title)) {
        return true;
      }

      // Check if the song alias matches the query, ignoring "," and "!" characters
      if (queryPtn.hasMatch(alias)) {
        return true;
      }

      // Check if the song content matches the query, ignoring "," and "!" characters
      if (queryPtn.hasMatch(content)) {
        return true;
      }

      return false;
    }).toList();

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(
        left: height! * 0.0082,
        right: height! * 0.0082,
      ),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return SongItem(
          song: result,
          height: height!,
          isSearching: true,
          onPressed: () {
            vm.localStorage.song = vm.setSong = result;
            vm.navigator.goToSongPresentor();
          },
        );
      },
    );
  }
}
