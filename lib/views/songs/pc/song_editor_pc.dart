import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_colors.dart';
import '../../../viewmodels/songs/song_editor_vm.dart';
import '../../../widgets/inputs/form_input.dart';
import '../../../widgets/progress/circular_progress.dart';

/// Song editor screen to draft a new song or edit an existing one
class SongEditorPc extends StatefulWidget {
  const SongEditorPc({Key? key}) : super(key: key);

  @override
  SongEditorPcState createState() => SongEditorPcState();
}

@visibleForTesting
class SongEditorPcState extends State<SongEditorPc>
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
          var mainContainer = SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FormInput(
                      iLabel: 'Song Title',
                      iController: vm.titleController!,
                      prefix: const Icon(Icons.text_fields),
                    ),
                    FormInput(
                      iLabel: 'Song Content',
                      iController: vm.contentController!,
                      prefix: const Icon(Icons.list),
                      isMultiline: true,
                      iType: TextInputType.multiline,
                    ),
                    FormInput(
                      iLabel: 'Song Key (Optional)',
                      iController: vm.keyController!,
                      prefix: const Icon(Icons.key),
                    ),
                    FormInput(
                      iLabel: 'Song Alias (Optional)',
                      iController: vm.aliasController!,
                      prefix: const Icon(Icons.text_format),
                    ),
                  ],
                ),
              ),
            ),
          );

          return Scaffold(
            backgroundColor: ThemeColors.backgroundGrey,
            appBar: AppBar(
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
            ),
            body: SizedBox(
              height: size!.height,
              child: vm.isBusy ? const CircularProgress() : mainContainer,
            ),
          );
        },
      ),
    );
  }
}
