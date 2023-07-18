import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../navigator/main_navigator.dart';
import '../../../navigator/mixin/back_navigator.dart';
import '../../../navigator/route_names.dart';
import '../../../theme/theme_colors.dart';
import '../../../utils/big_screen_intents.dart';
import '../../../vms/songs/song_presentor_vm.dart';
import '../../../widgets/general/present_on_pc.dart';
import '../../../widgets/progress/circular_progress.dart';
import '../../../widgets/provider/provider_widget.dart';

/// Screen to present a song in slide format
class SongPresentorPc extends StatefulWidget {
  static const String routeName = RouteNames.presentSongPc;
  const SongPresentorPc({Key? key}) : super(key: key);

  @override
  SongPresentorPcState createState() => SongPresentorPcState();
}

@visibleForTesting
class SongPresentorPcState extends State<SongPresentorPc>
    with BackNavigatorMixin
    implements SongPresentorNavigator {
  Size? size;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    await DesktopWindow.setFullScreen(true);
  }

  @override
  void dispose() {
    finish();
    super.dispose();
  }

  Future<void> finish() async {
    if (Platform.isMacOS) {
      await DesktopWindow.setFullScreen(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ProviderWidget<SongPresentorVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (ctx, vm, child, theme, localization) {
        vm.size = size;
        vm.context = ctx;
        vm.tr = AppLocalizations.of(ctx)!;

        var projection = Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              vm.pageTitle,
              style: const TextStyle(fontSize: 30),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () => vm.hintsDialog(ctx),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.info),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              height: size!.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.orange,
                    ThemeColors.accent,
                    ThemeColors.primary,
                    Colors.black,
                  ],
                ),
              ),
              child: LayoutBuilder(
                builder: (context, dimens) {
                  vm.size = size = Size(dimens.maxWidth, dimens.maxHeight);
                  return vm.isLoading
                      ? const CircularProgress()
                      : PresentOnPc(
                          index: vm.curSlide,
                          infos: vm.verseInfos,
                          contents: vm.widgetContent,
                          tabsWidth: size!.height * 0.08156,
                          indicatorWidth: size!.height * 0.08156,
                          onSelect: (index) =>
                              setState(() => vm.curSlide = index!),
                        );
                },
              ),
            ),
          ),
        );
        return Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.keyI): InfoIntent(),
            SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
            SingleActivator(LogicalKeyboardKey.arrowUp): PreviousIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): NextIntent(),
            SingleActivator(LogicalKeyboardKey.keyC): ChorusIntent(),
            SingleActivator(LogicalKeyboardKey.numpad1): VerseOneIntent(),
            SingleActivator(LogicalKeyboardKey.digit1): VerseOneIntent(),
            SingleActivator(LogicalKeyboardKey.numpad2): VerseTwoIntent(),
            SingleActivator(LogicalKeyboardKey.digit2): VerseTwoIntent(),
            SingleActivator(LogicalKeyboardKey.numpad3): VerseThreeIntent(),
            SingleActivator(LogicalKeyboardKey.digit3): VerseThreeIntent(),
            SingleActivator(LogicalKeyboardKey.numpad4): VerseFourIntent(),
            SingleActivator(LogicalKeyboardKey.digit4): VerseFourIntent(),
            SingleActivator(LogicalKeyboardKey.numpad5): VerseFiveIntent(),
            SingleActivator(LogicalKeyboardKey.digit5): VerseFiveIntent(),
            SingleActivator(LogicalKeyboardKey.numpad6): VerseSixIntent(),
            SingleActivator(LogicalKeyboardKey.digit6): VerseSixIntent(),
            SingleActivator(LogicalKeyboardKey.numpad7): VerseSevenIntent(),
            SingleActivator(LogicalKeyboardKey.digit7): VerseSevenIntent(),
            SingleActivator(LogicalKeyboardKey.keyL): VerseLastIntent(),
            SingleActivator(LogicalKeyboardKey.keyS): VerseSecondLastIntent(),
            //SingleActivator(LogicalKeyboardKey.arrowRight): BiggerFontIntent(),
            //SingleActivator(LogicalKeyboardKey.arrowLeft): SmallerFontIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              InfoIntent: CallbackAction<InfoIntent>(
                onInvoke: (InfoIntent intent) => vm.hintsDialog(context),
              ),
              CloseIntent: CallbackAction<CloseIntent>(
                onInvoke: (CloseIntent intent) => vm.navigator.goBack(),
              ),
              PreviousIntent: CallbackAction<PreviousIntent>(
                onInvoke: (PreviousIntent intent) => {
                  if (vm.curSlide != 0)
                    setState(() => vm.curSlide = vm.curSlide - 1),
                },
              ),
              NextIntent: CallbackAction<NextIntent>(
                onInvoke: (NextIntent intent) => {
                  if (vm.curSlide < vm.widgetContent.length)
                    setState(() => vm.curSlide = vm.curSlide + 1),
                },
              ),
              ChorusIntent: CallbackAction<ChorusIntent>(
                onInvoke: (ChorusIntent intent) => {
                  if (vm.hasChorus) setState(() => vm.curSlide = 1),
                },
              ),
              VerseOneIntent: CallbackAction<VerseOneIntent>(
                onInvoke: (VerseOneIntent intent) =>
                    setState(() => vm.curSlide = 0),
              ),
              VerseTwoIntent: CallbackAction<VerseTwoIntent>(
                onInvoke: (VerseTwoIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 3)
                    setState(() => vm.curSlide = 2)
                  else if (vm.widgetContent.length >= 2)
                    setState(() => vm.curSlide = 1)
                },
              ),
              VerseThreeIntent: CallbackAction<VerseThreeIntent>(
                onInvoke: (VerseThreeIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 5)
                    setState(() => vm.curSlide = 4)
                  else if (vm.widgetContent.length >= 3)
                    setState(() => vm.curSlide = 2)
                },
              ),
              VerseFourIntent: CallbackAction<VerseFourIntent>(
                onInvoke: (VerseFourIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 7)
                    setState(() => vm.curSlide = 6)
                  else if (vm.widgetContent.length >= 2)
                    setState(() => vm.curSlide = 3)
                },
              ),
              VerseFiveIntent: CallbackAction<VerseFiveIntent>(
                onInvoke: (VerseFiveIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 9)
                    setState(() => vm.curSlide = 8)
                  else if (vm.widgetContent.length >= 5)
                    setState(() => vm.curSlide = 2)
                },
              ),
              VerseSixIntent: CallbackAction<VerseSixIntent>(
                onInvoke: (VerseSixIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 11)
                    setState(() => vm.curSlide = 10)
                  else if (vm.widgetContent.length >= 6)
                    setState(() => vm.curSlide = 5)
                },
              ),
              VerseSevenIntent: CallbackAction<VerseSevenIntent>(
                onInvoke: (VerseSevenIntent intent) => {
                  if (vm.hasChorus && vm.widgetContent.length >= 13)
                    setState(() => vm.curSlide = 12)
                  else if (vm.widgetContent.length >= 7)
                    setState(() => vm.curSlide = 6)
                },
              ),
              VerseLastIntent: CallbackAction<VerseLastIntent>(
                onInvoke: (VerseLastIntent intent) => {
                  if (vm.hasChorus)
                    setState(() => vm.curSlide = vm.widgetContent.length - 2)
                  else
                    setState(() => vm.curSlide = vm.widgetContent.length - 1)
                },
              ),
              VerseSecondLastIntent: CallbackAction<VerseSecondLastIntent>(
                onInvoke: (VerseSecondLastIntent intent) => {
                  if (vm.hasChorus)
                    setState(() => vm.curSlide = vm.widgetContent.length - 4)
                  else
                    setState(() => vm.curSlide = vm.widgetContent.length - 2)
                },
              ),
              SmallerFontIntent: CallbackAction<SmallerFontIntent>(
                onInvoke: (SmallerFontIntent intent) {
                  if (vm.fSize > 5) {
                    setState(() => vm.curSlide = 0);
                    setState(() => vm.fSize = vm.fSize - 3);
                    vm.loadPresentor();
                  }
                  return null;
                },
              ),
              BiggerFontIntent: CallbackAction<BiggerFontIntent>(
                onInvoke: (BiggerFontIntent intent) {
                  if (vm.fSize < 100) {
                    setState(() => vm.curSlide = 0);
                    setState(() => vm.fSize = vm.fSize + 3);
                    vm.loadPresentor();
                  }
                  return null;
                },
              ),
            },
            child: Focus(autofocus: true, child: projection),
          ),
        );
      },
    );
  }

  @override
  void goToSongEditor() => MainNavigator.of(context).goToSongEditor();

  @override
  void goToSongEditorPc() => MainNavigator.of(context).goToSongEditorPc();

  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();
}
