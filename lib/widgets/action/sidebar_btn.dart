import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../model/general/general.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';

class SidebarBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final double iconSize;
  final bool compact;
  final bool transparent;
  final double height;
  final PageType pageType;
  final bool dottedBorder;

  const SidebarBtn(
    this.icon,
    this.label, {
    Key? key,
    this.onPressed,
    this.isSelected = false,
    this.iconSize = 26,
    this.compact = false,
    this.transparent = true,
    this.height = 60,
    this.pageType = PageType.search,
    this.dottedBorder = false,
  }) : super(key: key);

  @override
  SidebarBtnState createState() => SidebarBtnState();
}

class SidebarBtnState extends State<SidebarBtn> {
  @override
  Widget build(BuildContext context) {
    TextStyle btnStyle = TextStyles.Btn;
    Widget btnContents = Row(
      mainAxisAlignment:
          widget.compact ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        if (!widget.compact) const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            widget.icon,
            size: widget.iconSize - 4.0,
            color: widget.isSelected ? Colors.white : Colors.black,
          ),
        ),
        if (!widget.compact) ...{
          const SizedBox(width: 20),
          Text(widget.label.toUpperCase(), style: btnStyle).flexible()
        }
      ],
    )
        .opacity(widget.isSelected ? 1 : .8, animate: true)
        .animate(.3.seconds, Curves.easeOut);

    return RawMaterialButton(
      textStyle: TextStyles.Btn.bold
          .size(20)
          .textColor(widget.isSelected ? Colors.white : Colors.black),
      fillColor: widget.isSelected ? ThemeColors.primary : Colors.transparent,
      highlightColor: Colors.white.withOpacity(.1),
      focusElevation: 0,
      hoverColor: ThemeColors.lightGrey,
      hoverElevation: 1,
      highlightElevation: 0,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: widget.compact
          ? const CircleBorder()
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
      onPressed: widget.onPressed,
      child: btnContents,
    );
  }
}
