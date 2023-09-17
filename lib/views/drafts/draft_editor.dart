import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../theme/theme_colors.dart';
import '../../viewmodels/drafts/draft_editor_vm.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/progress/circular_progress.dart';

/// Song editor screen to draft a new song or edit an existing one
class DraftEditor extends StatefulWidget {
  const DraftEditor({Key? key}) : super(key: key);

  @override
  DraftEditorState createState() => DraftEditorState();
}

@visibleForTesting
class DraftEditorState extends State<DraftEditor>
    implements DraftEditorNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return ChangeNotifierProvider<DraftEditorVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<DraftEditorVm>(
        builder: (ctx, vm, child) {
          vm.notEmpty = args['not_empty'];
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
            appBar: AppBar(
              title: Text(vm.pageTitle!),
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
            body: vm.isBusy
                ? const CircularProgress()
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(child: mainContainer),
                  ),
          );
        },
      ),
    );
  }
}
