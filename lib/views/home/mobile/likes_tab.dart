part of '../home_screen.dart';

/// Tab screen with list of liked songs
// ignore: must_be_immutable
class LikesTab extends StatelessWidget {
  final HomeVm vm;
  LikesTab(this.vm, {Key? key}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    var listContainer = Container(
      height: size!.height * 0.7,
      padding: const EdgeInsets.only(right: 2),
      child: Scrollbar(
        thickness: 10,
        radius: const Radius.circular(20),
        child: ListView.builder(
          itemCount: vm.likes!.length,
          padding: EdgeInsets.all(
            size!.height * 0.015,
          ),
          itemBuilder: (context, index) {
            final SongExt song = vm.likes![index];
            return SongItem(
              song: song,
              height: size!.height,
              onPressed: () {
                vm.localStorage.song = vm.setSong = song;
                vm.navigator.goToSongPresentor();
              },
            );
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ThemeColors.backgroundGrey,
      body: ContextMenuOverlay(
        cardBuilder: (_, children) => Container(
          decoration: const BoxDecoration(
            color: ThemeColors.accent,
            boxShadow: [BoxShadow(blurRadius: 5)],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(children: children),
        ),
        child: SizedBox(
          height: size!.height,
          child: vm.isBusy
              ? const ListLoading()
              : vm.likes!.isNotEmpty
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
