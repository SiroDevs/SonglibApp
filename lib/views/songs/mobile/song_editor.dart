import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../theme/theme_colors.dart';
import '../../../viewmodels/songs/song_editor_vm.dart';
import '../../../widgets/inputs/form_input.dart';
import '../../../widgets/progress/circular_progress.dart';

/// Screen to present a song in slide format
class SongEditor extends StatefulWidget {
  const SongEditor({Key? key}) : super(key: key);

  @override
  SongEditorState createState() => SongEditorState();
}

@visibleForTesting
class SongEditorState extends State<SongEditor>
    implements SongEditorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SongEditorVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<SongEditorVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;

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
              child: vm.isBusy
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
      ),
    );
  }
}
