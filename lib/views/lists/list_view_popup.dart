import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../model/base/listed.dart';
import '../../model/base/songext.dart';
import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../viewmodels/lists/list_popup_vm.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/progress/circular_progress.dart';

/// Popup for selecting a song list on which to add a song to
class ListViewPopup extends StatefulWidget {
  final SongExt song;
  const ListViewPopup({Key? key, required this.song}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ListViewPopupState(song);
  }
}

@visibleForTesting
class ListViewPopupState extends State<ListViewPopup>
    implements ListPopupNavigator {
  ListViewPopupState(this.song);
  SongExt? song;
  ListPopupVm? vm;
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ListPopupVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<ListPopupVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;
          var mainContainer = Scrollbar(
            thickness: 10,
            radius: const Radius.circular(20),
            child: FutureBuilder<List<Listed>?>(
              future: vm!.fetchListedData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Listed>?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final Listed listed = snapshot.data![index];
                        return ListedItem(
                          listed: listed,
                          height: size!.height,
                          onPressed: () {
                            vm!.addSongToList(listed, song!);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  } else {
                    return NoDataToShow(
                      title: tr.errorOccurred,
                      description: tr.errorOccurredBody1,
                    );
                  }
                } else if (snapshot.hasError) {
                  return NoDataToShow(
                    title: tr.errorOccurred,
                    description: tr.errorOccurredBody1,
                  );
                } else {
                  return const CircularProgress();
                }
              },
            ),
          );

          return Scaffold(
            backgroundColor: ThemeColors.accent,
            appBar: AppBar(
              title: Text(tr.addSongtoList),
              actions: <Widget>[
                InkWell(
                  onTap: () => newListForm(context),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            body: mainContainer,
          );
        },
      ),
    );
  }

  Future<void> newListForm(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Draft a New List',
          style: TextStyle(
            fontSize: 22,
            color: ThemeColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormInput(
                iLabel: 'Title',
                iController: vm!.titleController!,
              ),
              FormInput(
                iLabel: 'Description (Optional)',
                iController: vm!.contentController!,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              vm!.saveNewList();
              vm!.titleController!.clear();
              vm!.contentController!.clear();
              Navigator.pop(context);
            },
            child: const Text("SAVE LIST"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
        ],
      ),
    );
  }

  @override
  void goToPresentor() => MainNavigator.of(context).goToSongPresentor();
}
