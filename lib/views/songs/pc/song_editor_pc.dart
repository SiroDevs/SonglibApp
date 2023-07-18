import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../navigator/mixin/back_navigator.dart';
import '../../../navigator/route_names.dart';
import '../../../theme/theme_colors.dart';
import '../../../vms/songs/song_editor_vm.dart';
import '../../../widgets/inputs/form_input.dart';
import '../../../widgets/progress/circular_progress.dart';
import '../../../widgets/provider/provider_widget.dart';

/// Song editor screen to draft a new song or edit an existing one
class SongEditorPc extends StatefulWidget {
  static const String routeName = RouteNames.editSongPc;
  const SongEditorPc({Key? key}) : super(key: key);

  @override
  SongEditorPcState createState() => SongEditorPcState();
}

@visibleForTesting
class SongEditorPcState extends State<SongEditorPc>
    with BackNavigatorMixin
    implements SongEditorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ProviderWidget<SongEditorVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) {
        //vm.context = context;
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
                    iController: viewModel.titleController!,
                    prefix: const Icon(Icons.text_fields),
                  ),
                  FormInput(
                    iLabel: 'Song Content',
                    iController: viewModel.contentController!,
                    prefix: const Icon(Icons.list),
                    isMultiline: true,
                    iType: TextInputType.multiline,
                  ),
                  FormInput(
                    iLabel: 'Song Key (Optional)',
                    iController: viewModel.keyController!,
                    prefix: const Icon(Icons.key),
                  ),
                  FormInput(
                    iLabel: 'Song Alias (Optional)',
                    iController: viewModel.aliasController!,
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
                onTap: () => viewModel.saveChanges(),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.check),
                ),
              ),
              InkWell(
                onTap: () => viewModel.confirmCancel(context),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.clear),
                ),
              ),
            ],
          ),
          body: SizedBox(
            height: size!.height,
            child:
                viewModel.isLoading ? const CircularProgress() : mainContainer,
          ),
        );
      },
    );
  }
}
