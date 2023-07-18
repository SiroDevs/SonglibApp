part of '../home_screen.dart';

/// Tab screen with list of song lists
// ignore: must_be_immutable
class ListPopup extends StatelessWidget {
  final HomeVm vm;
  final SongExt song;
  ListPopup({Key? key, required this.vm, required this.song}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    var listContainer = ListView.builder(
      itemCount: vm.listeds!.length,
      padding: EdgeInsets.all(
        size!.height * 0.015,
      ),
      itemBuilder: (context, index) {
        final Listed listed = vm.listeds![index];
        return ListedItem(
          listed: listed,
          height: size!.height,
          onPressed: () {
            vm.addSongToList(song);
            Navigator.pop(context);
          },
        );
      },
    );

    return Scaffold(
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
      body: ContextMenuOverlay(
        cardBuilder: (_, children) => Container(
          decoration: const BoxDecoration(
            color: ThemeColors.accent,
            boxShadow: [BoxShadow(blurRadius: 5)],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(children: children),
        ),
        child: Container(
          height: size!.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, ThemeColors.accent, Colors.black],
            ),
          ),
          child: vm.isLoading
              ? const CircularProgress()
              : vm.listeds!.isNotEmpty
                  ? listContainer
                  : NoDataToShow(
                      title: tr.itsEmptyHere1,
                      description: tr.itsEmptyHereBody4,
                    ),
        ),
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
                iController: vm.titleController!,
              ),
              FormInput(
                iLabel: 'Description (Optional)',
                iController: vm.contentController!,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              vm.saveNewList();
              vm.titleController!.clear();
              vm.contentController!.clear();
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
}
