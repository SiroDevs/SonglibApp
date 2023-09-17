import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../model/base/book.dart';
import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/songext.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';
import '../../utils/utilities.dart';
import 'labels.dart';

var locale = 'en';

class BookItem extends StatelessWidget {
  final Book book;
  final bool selected;
  final Function()? onPressed;

  const BookItem({
    Key? key,
    required this.book,
    this.selected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        color: selected ? Colors.deepOrange : Colors.white,
        elevation: 5,
        child: Center(
          child: ListTile(
            onTap: onPressed,
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                selected ? Icons.check_box : Icons.check_box_outline_blank,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                refineTitle(book.title!),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                "${book.songs!} ${book.subTitle} songs",
                style: TextStyle(
                  fontSize: 18,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SongBook extends StatelessWidget {
  final Book book;
  final bool isSelected;
  final Function()? onPressed;

  const SongBook({
    Key? key,
    required this.book,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: RawMaterialButton(
        textStyle: TextStyles.Btn.bold
            .size(16)
            .textColor(isSelected ? Colors.white : ThemeColors.primary),
        fillColor: isSelected ? ThemeColors.primary : ThemeColors.accent,
        highlightColor: Colors.white.withOpacity(.1),
        focusElevation: 0,
        hoverColor: isSelected ? ThemeColors.primary : Colors.white,
        hoverElevation: 1,
        highlightElevation: 0,
        elevation: 3,
        padding: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: ThemeColors.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          width: 100,
          child: Text(
            truncateString(19, refineTitle(book.title!)),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}

class ListedItem extends StatelessWidget {
  final Listed listed;
  final double height;
  final bool isSelected;
  final Function()? onPressed;

  const ListedItem({
    Key? key,
    required this.listed,
    required this.height,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateValue = DateTime.parse(listed.updated!);
    final String lastUpdate = timeago.format(dateValue);

    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
      child: RawMaterialButton(
        fillColor: isSelected ? ThemeColors.primary : Colors.white,
        highlightColor: Colors.white.withOpacity(.1),
        focusElevation: 0,
        hoverColor: isSelected ? ThemeColors.primary : ThemeColors.accent,
        hoverElevation: 1,
        highlightElevation: 0,
        padding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              listed.title!,
              maxLines: 1,
              style: TextStyle(
                fontSize: height * 0.0261,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: ThemeColors.accent, height: height * 0.0049),
            const SizedBox(height: 5),
            listed.description!.isNotEmpty
                ? Text(
                    listed.description!,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: height * 0.015,
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              children: <Widget>[
                const Spacer(),
                TagView(
                  tagText:
                      '${listed.song!} song${listed.song! == 1 ? '' : 's'}',
                  height: height,
                ),
                TagView(tagText: 'Updated $lastUpdate', height: height),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SongItem extends StatelessWidget {
  final SongExt song;
  final double height;
  final bool isSelected;
  final bool isSearching;
  final Function()? onPressed;

  SongItem({
    Key? key,
    required this.song,
    required this.height,
    this.isSelected = false,
    this.isSearching = false,
    this.onPressed,
  }) : super(key: key);

  bool hasChorus = false;
  String chorusText = '', versesText = '';

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    final verses = song.content!.split("##");

    if (song.content!.contains("CHORUS")) {
      hasChorus = true;
      chorusText = tr.hasChorus;
      versesText = '${verses.length - 1} ${tr.verses}';
    } else {
      versesText = '${verses.length} ${tr.verses}';
    }

    versesText = verses.length == 1 ? versesText : '${versesText}s';
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
      child: RawMaterialButton(
        fillColor: isSelected ? ThemeColors.primary : Colors.white,
        highlightColor: Colors.white.withOpacity(.1),
        focusElevation: 0,
        hoverColor: isSelected ? ThemeColors.primary : ThemeColors.accent,
        hoverElevation: 1,
        highlightElevation: 0,
        padding: const EdgeInsets.all(5),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              songItemTitle(song.songNo!, song.title!),
              maxLines: 1,
              style: TextStyles.Body1.size(height * 0.0261)
                  .bold
                  .textColor(isSelected ? Colors.white : Colors.black)
                  .textHeight(1.5),
            ),
            Divider(color: ThemeColors.accent, height: height * 0.0049),
            Text(
              refineContent(verses[0]),
              maxLines: 2,
              style: TextStyles.Body1.size(height * 0.0228)
                  .textColor(isSelected ? Colors.white : Colors.black)
                  .textHeight(1.5),
            ),
            Container(
              height: height * 0.035,
              width: MediaQuery.of(context).size.width - 30,
              margin: const EdgeInsets.only(right: 5, bottom: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  if (isSearching)
                    TagView(
                        tagText: refineTitle(song.songbook!), height: height),
                  TagView(tagText: versesText, height: height),
                  if (hasChorus) TagView(tagText: chorusText, height: height),
                  Container(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DraftItem extends StatelessWidget {
  final Draft draft;
  final double height;
  final Function()? onPressed;

  DraftItem({
    Key? key,
    required this.draft,
    required this.height,
    this.onPressed,
  }) : super(key: key);

  bool hasChorus = false;
  String chorusText = '', versesText = '';

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    final verses = draft.content!.split("##");

    if (draft.content!.contains("CHORUS")) {
      hasChorus = true;
      chorusText = tr.hasChorus;
      versesText = '${verses.length - 1} ${tr.verses}';
    } else {
      versesText = '${verses.length} ${tr.verses}';
    }

    versesText = verses.length == 1 ? versesText : '${versesText}s';

    return Hero(
      tag: 'DraftIndex_${draft.id}',
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: height * 0.0049),
          child: Padding(
            padding: EdgeInsets.all(height * 0.0049),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  draft.title!,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: height * 0.0261,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: ThemeColors.accent, height: height * 0.0049),
                Text(
                  refineContent(verses[0]),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: height * 0.0228,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    TagView(tagText: versesText, height: height),
                    hasChorus
                        ? TagView(tagText: chorusText, height: height)
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
