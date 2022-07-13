import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';

class SearchView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Song>? songs;
  final double? height;

  SearchView({
    Key? key,
    required this.songs,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchWidget<Song>(
      dataList: songs!,
      hideSearchBoxWhenItemSelected: false,
      listContainerHeight: height! / 4,
      queryBuilder: (query, list) {
        return list
            .where(
              (song) => song.title!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      },
      popupListItemBuilder: (song) {
        return popupListSongWidget(song);
      },
      selectedItemBuilder: (selectedSong, deleteSelectedSong) {
        return selectedSongWidget(selectedSong, deleteSelectedSong);
      },
      noItemsFoundWidget: noSongsFound(),
      textFieldBuilder: (controller, focusNode) {
        return searchField(controller, focusNode);
      },
      onItemSelected: (song) {
        //_selectedItem = item;
      },
    );
  }

  Widget searchField(
      TextEditingController qryController, FocusNode? focusNode) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: height! * 0.1,
      child: TextField(
        controller: qryController,
        focusNode: focusNode,
        style: const TextStyle(fontSize: 20, color: AppColors.primaryColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
          suffixIcon: const Icon(Icons.mic, color: AppColors.primaryColor),
          border: InputBorder.none,
          hintText: "Search for a Song",
          contentPadding: const EdgeInsets.all(20),
        ),
        onTap: () => controller.setSearchingMode(true),
        onSubmitted: (qry) => controller.setSearchingMode(false),
      ),
    );
  }

  Widget selectedSongWidget(
    Song selectedSong,
    VoidCallback deleteSelectedSong,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedSong.title!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedSong,
          ),
        ],
      ),
    );
  }

  Widget noSongsFound() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900]!.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Songs Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900]!.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget popupListSongWidget(Song song) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        song.title!,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
