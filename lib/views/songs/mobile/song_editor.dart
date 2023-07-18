import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../navigator/mixin/back_navigator.dart';
import '../../../navigator/route_names.dart';
import '../../../theme/theme_colors.dart';
import '../../../vms/songs/song_editor_vm.dart';
import '../../../widgets/inputs/form_input.dart';
import '../../../widgets/progress/circular_progress.dart';
import '../../../widgets/provider/provider_widget.dart';

/// Screen to present a song in slide format
class SongEditor extends StatefulWidget {
  static const String routeName = RouteNames.editSong;
  const SongEditor({Key? key}) : super(key: key);

  @override
  SongEditorState createState() => SongEditorState();
}

@visibleForTesting
class SongEditorState extends State<SongEditor>
    with BackNavigatorMixin
    implements SongEditorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    return ProviderWidget<SongEditorVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, vm, child, theme, localization) {
        vm.tr = AppLocalizations.of(context)!;

        var appBarWidget = AppBar(
          title: const Text('Edit Your Song'),
          actions: <Widget>[
            InkWell(
              onTap: () => vm.saveChanges(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.check),
              ),
            ),
            InkWell(
              onTap: () => vm.confirmCancel(context),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.clear),
              ),
            ),
          ],
        );
        var mainContainer = Column(
          children: <Widget>[
            FormInput(
              iLabel: 'Title',
              iController: vm.titleController!,
              prefix: const Icon(Icons.text_fields),
            ),
            FormInput(
              iLabel: 'Content',
              iController: vm.contentController!,
              prefix: const Icon(Icons.list),
              isMultiline: true,
              iType: TextInputType.multiline,
              maxInput: 20000,
            ).expanded(),
            [
              FormInput(
                iLabel: 'Key (Optional)',
                iController: vm.keyController!,
                prefix: const Icon(Icons.key),
              ).expanded(),
              FormInput(
                iLabel: 'Alias (Optional)',
                iController: vm.aliasController!,
                prefix: const Icon(Icons.text_format),
              ).expanded(),
            ].toRow(),
          ],
        );

        return Scaffold(
          backgroundColor: ThemeColors.backgroundGrey,
          appBar: appBarWidget,
          body: SizedBox(
            height: size!.height,
            child: vm.isLoading
                ? const CircularProgress()
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      child: mainContainer,
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => vm.saveChanges(),
            backgroundColor: ThemeColors.primary,
            child: const Icon(Icons.check, color: Colors.white),
          ),
        );
      },
    );
  }
}
