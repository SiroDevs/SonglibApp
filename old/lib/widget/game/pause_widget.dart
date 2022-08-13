import 'package:songlib/screen/base/simple_screen.dart';
import 'package:songlib/widget/general/styled/songlib_button.dart';
import 'package:songlib/widget/menu_background/menu_box.dart';
import 'package:songlib/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class PauseWidget extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onSave;
  final VoidCallback onStop;

  const PauseWidget({
    required this.onContinue,
    required this.onSave,
    required this.onStop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      childBuilder: (context, theme, localization) => SimpleScreen(
        transparant: true,
        child: MenuBox(
          title: localization.pausedTitle,
          child: Center(
            heightFactor: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SongLibButton(
                  type: SongLibButtonType.green,
                  text: localization.continueButton,
                  onClick: onContinue,
                ),
                SongLibButton(
                  type: SongLibButtonType.yellow,
                  text: localization.saveButton,
                  onClick: onSave,
                ),
                SongLibButton(
                  type: SongLibButtonType.red,
                  text: localization.mainMenuButton,
                  onClick: onStop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}