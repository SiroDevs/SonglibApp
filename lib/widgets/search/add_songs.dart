import 'package:flutter/material.dart';

import '../../../../model/base/songext.dart';
import '../../../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/home/home_vm.dart';
import '../../viewmodels/lists/list_view_vm.dart';
import '../../../../widgets/general/list_items.dart';
/// Search for songs screen
class AddSongs extends SearchDelegate<List> {
  final HomeVm homeVm;
  final ListViewVm listVm;
  final double? height;

  AddSongs(BuildContext context, this.homeVm, this.listVm, this.height);

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
      // Clear search query
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      // Return to search tab
      onPressed: () => close(context, homeVm.songs!),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => searchThis(context);

  @override
  Widget buildSuggestions(BuildContext context) => searchThis(context);

  Widget searchThis(BuildContext context) {
    List<SongExt> matchQuery = homeVm.songs!.where((s) {
      return (isNumeric(query) && s.songNo == int.parse(query)) ||
          s.title!.toLowerCase().contains(query.toLowerCase()) ||
          s.alias!.toLowerCase().contains(query.toLowerCase()) ||
          s.content!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.all(height! * 0.015),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return SongItem(
          song: result,
          height: height!,
          isSearching: true,
          onPressed: () {
            listVm.addSongToList(result);
            close(context, homeVm.songs!);
          },
        );
      },
    );
  }
}
