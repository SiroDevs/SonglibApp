import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';

import '../../../model/base/songext.dart';
import '../../../widgets/general/list_items.dart';
import '../../viewmodels/lists/list_view_vm.dart';

class ListSearchSongs extends SearchDelegate<List> {
  List<SongExt> itemList = [], filtered = [];
  final ListViewVm viewModel;
  final double? height;

  ListSearchSongs(
      BuildContext context, this.viewModel, this.height, this.itemList) {
    filtered = itemList;
  }

  @override
  String get searchFieldLabel => "Search a Song";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xAAEB5200),
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.white),
      ),
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
      onPressed: () => close(context, itemList),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SongExt> matchQuery = [];
    for (var item in itemList) {
      if (item.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: itemList.length,
      padding: EdgeInsets.only(
        left: height! * 0.0082,
        right: height! * 0.0082,
      ),
      itemBuilder: (context, index) {
        final SongExt song = itemList[index];
        return SongItem(
          song: song,
          height: height!,
          onPressed: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SongExt> matchQuery = [];

    for (var item in itemList) {
      if (item.title!.toLowerCase().startsWith(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
      ),
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.title!),
          onTap: () async {
            close(context, filtered);
          },
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
