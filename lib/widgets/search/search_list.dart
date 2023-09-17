import 'package:flutter/material.dart';

import '../../../../model/base/listed.dart';
import '../../navigator/main_navigator.dart';
import '../../viewmodels/home/home_vm.dart';
import '../../../../widgets/general/list_items.dart';

class SearchList extends SearchDelegate<List> {
  List<Listed> itemList = [], filtered = [];
  final HomeVm vm;
  final double? height;

  SearchList(BuildContext context, this.vm, this.height, this.itemList) {
    filtered = itemList;
  }

  @override
  String get searchFieldLabel => "Search a List";

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
    List<Listed> matchQuery = [];
    for (var item in itemList) {
      if (item.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = vm.listeds![index];
        return ListedItem(
          listed: result,
          height: height!,
          onPressed: () {
            vm.localStorage.listed = result;
            MainNavigator.of(context).goToListView();
          },
        );
      },
      itemCount: vm.listeds!.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Listed> matchQuery = [];

    for (var item in itemList) {
      if (item.title!.toLowerCase().startsWith(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListedItem(
          listed: result,
          height: height!,
          onPressed: () {
            vm.localStorage.listed = result;
            MainNavigator.of(context).goToListView();
          },
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
