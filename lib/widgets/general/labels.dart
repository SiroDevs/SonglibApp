import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class TextLabel extends StatelessWidget {
  final String? label;
  final bool? isDark;
  final double? paddingV;
  final bool? hasRoute;
  final bool? makeBold;
  final double? fontsize;
  final Color? forecolor;
  final Function()? onTap;

  const TextLabel({
    Key? key,
    required this.label,
    this.isDark = true,
    this.paddingV = 0,
    this.hasRoute = false,
    this.makeBold = false,
    this.fontsize = 18,
    this.forecolor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textcolor;
    if (forecolor == null) {
      if (hasRoute!) {
        textcolor = ThemeColors.accent;
      } else {
        if (isDark!) {
          textcolor = Colors.white;
        } else {
          textcolor = ThemeColors.primary;
        }
      }
    } else {
      textcolor = forecolor;
    }
    return Container(
      padding: EdgeInsets.all(paddingV!),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Text(
            label!,
            style: TextStyle(
              fontSize: fontsize,
              color: textcolor,
              fontWeight: hasRoute!
                  ? FontWeight.bold
                  : (makeBold! ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String? title;
  final String? description;
  final Function()? onTap;
  final Color? txColor;
  final Color? bgColor;
  final double ftSize;
  final double bdRadius;
  final EdgeInsetsGeometry cPadding;

  const CustomCard({
    Key? key,
    required this.title,
    this.description = "",
    required this.onTap,
    this.txColor = Colors.white,
    this.bgColor = ThemeColors.primary,
    this.ftSize = 20,
    this.bdRadius = 5,
    this.cPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: cPadding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(bdRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold, color: txColor),
        ),
        subtitle: description!.isEmpty
            ? const SizedBox.shrink()
            : Text(
                description!,
                style: TextStyle(color: txColor),
                maxLines: 2,
              ),
        onTap: onTap,
      ),
    );
  }
}

class NoDataToShow extends StatelessWidget {
  final String? title;
  final String? description;

  const NoDataToShow({Key? key, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 175,
        margin: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5)],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 20,
                  color: ThemeColors.primary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description!,
                style: const TextStyle(fontSize: 16),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class TagView extends StatelessWidget {
  final String tagText;
  final double height;

  const TagView({Key? key, required this.tagText, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      if (tagText.isNotEmpty) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: height * 0.0049),
          margin: EdgeInsets.only(top: 2, right: height * 0.008),
          decoration: BoxDecoration(
            color: ThemeColors.primary,
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            tagText,
            style: TextStyle(
              fontSize: height * 0.0195,
              color: Colors.white,
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } on Exception {
      return const SizedBox.shrink();
    }
  }
}

class PresentorInfo extends StatelessWidget {
  final String info;
  final double fontSize;

  const PresentorInfo({Key? key, required this.info, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          info,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PresentorText extends StatelessWidget {
  final String lyrics;
  final Size size;
  final Function()? onDoubleTap;
  final Function()? onLongPress;

  const PresentorText({
    Key? key,
    required this.lyrics,
    required this.size,
    this.onDoubleTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lineCount = '#'.allMatches(lyrics).length;

    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: AutoSizeText(
                lyrics.replaceAll("#", "\n"),
                style: const TextStyle(fontSize: 60),
                maxLines: (lineCount + 1) * 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
