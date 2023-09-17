import 'package:flutter/material.dart';

import '../../../../theme/theme_colors.dart';

class TabIcon extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;

  const TabIcon({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'TabIcon_$title',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Icon(
                iconData,
                color: ThemeColors.primary,
                size: 20,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TabsIcons extends StatelessWidget {
  final TabController controller;

  TabsIcons({Key? key, required this.controller}) : super(key: key);

  List<Widget> icons = [];

  @override
  Widget build(BuildContext context) {
    icons = [
      TabIcon(
        title: 'Lists',
        iconData: Icons.list_alt,
        onTap: () => controller.index == 0,
      ),
      TabIcon(
        title: 'Search',
        iconData: Icons.search,
        onTap: () => controller.index == 1,
      ),
      TabIcon(
        title: 'Notes',
        iconData: Icons.edit,
        onTap: () => controller.index == 2,
      ),
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          controller.index == 0 ? const SizedBox.shrink() : icons[controller.index - 1],
          controller.index == (icons.length - 1)
              ? const SizedBox.shrink()
              : icons[controller.index + 1],
        ],
      ),
    );
  }

}

// ignore: must_be_immutable
class TabsIndicator extends StatelessWidget {
  final TabController controller;

  const TabsIndicator({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Container(
            height: 30,
            margin: const EdgeInsets.only(bottom: 40),
            child: TabBar(
              isScrollable: true,
              controller: controller,
              indicatorColor: Colors.transparent,
              tabs: [
                pageIndicator(controller.index == 0),
                pageIndicator(controller.index == 1),
                pageIndicator(controller.index == 2),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget pageIndicator(bool isCurrent) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: isCurrent ? ThemeColors.primary : ThemeColors.accent,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}
