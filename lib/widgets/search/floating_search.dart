import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../model/base/songext.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';
import '../../utils/utilities.dart';
import '../general/list_items.dart';

class FloatingSearch extends StatefulWidget {
  final List<SongExt> items;
  final double lMargin;
  final double rMargin;
  final FocusNode? focus;
  final Function(SongExt) onPressed;

  const FloatingSearch({
    super.key,
    required this.items,
    required this.onPressed,
    this.lMargin = 10,
    this.rMargin = 10,
    this.focus,
  });
  @override
  FloatingSearchState createState() => FloatingSearchState();
}

class FloatingSearchState extends State<FloatingSearch> {
  TextEditingController qryController = TextEditingController();
  late FocusNode focusNode;
  List<SongExt> filtered = [];
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focus ?? FocusNode();
    filtered = widget.items;
    focusNode.addListener(onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focus == null) {
      focusNode.removeListener(onFocusChange);
      focusNode.dispose();
    }
    super.dispose();
  }

  void onFocusChange() {
    setState(() => hasFocus = focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var searchContainer = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        controller: qryController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: InkWell(
            onTap: () => qryController.clear(),
            child: const Icon(Icons.clear, color: ThemeColors.primary),
          ),
          labelStyle: const TextStyle(fontSize: 18, color: ThemeColors.primary),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(fontSize: 18, color: ThemeColors.primary),
        textInputAction: TextInputAction.done,
        onChanged: (String query) {
          setState(
            () => filtered = seachSongByQuery(query, widget.items),
          );
        },
      ),
    );

    var resultsContainer = Container(
      height: size.height / 2,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeColors.backgroundGrey,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(Corners.s10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (ctx, index) {
          SongExt song = filtered[index];
          return SongItem(
            song: song,
            isSearching: true,
            height: size.height,
            onPressed: () => widget.onPressed(song),
          );
        },
      ),
    );
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Row(
        children: [
          SizedBox(width: widget.lMargin),
          Column(
            children: [
              const SizedBox(height: 30),
              searchContainer,
              if (hasFocus) resultsContainer,
            ],
          ).expanded(),
          SizedBox(width: widget.rMargin),
        ],
      ),
    );
  }
}
