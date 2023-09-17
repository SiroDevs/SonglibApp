import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../model/general/general.dart';
import '../../theme/theme_colors.dart';
import 'sidebar_btn.dart';

class Sidebar extends StatelessWidget {
  final Function(PageType) onPageSelect;
  final PageType? pageType;
  final bool isWeb;

  const Sidebar({
    Key? key,
    required this.pageType,
    required this.onPageSelect,
    this.isWeb = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;

    var isWebColumn = Column(
      children: <Widget>[
        SidebarBtn(
          Icons.search,
          tr.searchTitle,
          pageType: PageType.search,
          isSelected: pageType == PageType.search,
          onPressed: () => onPageSelect(PageType.search),
        ),
        const Divider(color: ThemeColors.primaryDark),
        const Spacer(),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.support,
          tr.helpdeskTitle,
          pageType: PageType.helpdesk,
          isSelected: pageType == PageType.helpdesk,
          onPressed: () => onPageSelect(PageType.helpdesk),
        ),
      ],
    );

    var notWebColumn = Column(
      children: <Widget>[
        SidebarBtn(
          Icons.list,
          tr.listTitle,
          pageType: PageType.lists,
          isSelected: pageType == PageType.lists,
          onPressed: () => onPageSelect(PageType.lists),
        ),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.search,
          tr.searchTitle,
          pageType: PageType.search,
          isSelected: pageType == PageType.search,
          onPressed: () => onPageSelect(PageType.search),
        ),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.favorite,
          tr.likesTitle,
          pageType: PageType.likes,
          isSelected: pageType == PageType.likes,
          onPressed: () => onPageSelect(PageType.likes),
        ),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.edit,
          tr.draftTitle,
          pageType: PageType.drafts,
          isSelected: pageType == PageType.drafts,
          onPressed: () => onPageSelect(PageType.drafts),
        ),
        const Divider(color: ThemeColors.primaryDark),
        const Spacer(),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.support,
          tr.helpdeskTitle,
          pageType: PageType.helpdesk,
          isSelected: pageType == PageType.helpdesk,
          onPressed: () => onPageSelect(PageType.helpdesk),
        ),
        const Divider(color: ThemeColors.primaryDark),
        SidebarBtn(
          Icons.settings,
          tr.settingsTitle,
          pageType: PageType.settings,
          isSelected: pageType == PageType.settings,
          onPressed: () => onPageSelect(PageType.settings),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: ThemeColors.accent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: (isWeb ? isWebColumn : notWebColumn)
          .padding(bottom: 20)
          .constrained(maxWidth: 280),
    );
  }
}
