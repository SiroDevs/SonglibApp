import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../theme/theme_colors.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;
  final TextEditingController? searchController;
  const SearchWidget({
    Key? key,
    required this.onSearch,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: searchController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: ThemeColors.primaryDark),
          suffixIcon: InkWell(
            onTap: () => searchController!.clear(),
            child: const Icon(Icons.clear, color: ThemeColors.primaryDark),
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(fontSize: 18, color: ThemeColors.primaryDark),
        textInputAction: TextInputAction.done,
        onChanged: (String query) => onSearch(query),
      ).decorated(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

