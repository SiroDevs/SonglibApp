import 'package:flutter/material.dart';

abstract class MainNavigation {
  void goBack<T>({T? result});

  void goToSplash();
  void goToOnboarding();
  void goToSelection();
  void goToHome(); 
  void goToSongPresentor();
  void goToSongPresentorPc();
  void goToDraftPresentor();
  void goToDraftPresentorPc();
  void goToSongEditor();
  void goToSongEditorPc();
  void goToDraftEditor(bool notEmpty);
  void goToListView();
  void goToSettings();
  void goToHelpDesk();
  void goToDonation();
  void goToUser();
  void goToSignin();
  void goToSignup();

  void showCustomDialog<T>({required WidgetBuilder builder});
}

mixin MainNavigationMixin<T extends StatefulWidget> on State<T>
    implements MainNavigation {}
