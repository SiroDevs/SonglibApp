part of '../home_screen.dart';

/// Tab screen with list of liked songs
// ignore: must_be_immutable
class HistoryTab extends StatelessWidget {
  final HomeVm vm;
  HistoryTab(this.vm, {Key? key}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    var titleContainer = vm.isBusy
        ? PageTitle(label: tr.listTitle, size: size)
        : vm.books!.isNotEmpty
            ? PageSearch(
                label: tr.listTitle,
                size: size,
                onTap: () async {
                  await showSearch(
                    context: context,
                    delegate: SearchList(
                      context,
                      vm,
                      size!.height,
                      vm.listeds!,
                    ),
                  );
                },
              )
            : PageTitle(label: tr.listTitle, size: size);
    var listContainer = Container(
      height: size!.height * 0.7,
      padding: const EdgeInsets.only(right: 2),
      child: Scrollbar(
        thickness: 10,
        radius: const Radius.circular(20),
        child: ListView.builder(
          itemCount: vm.listeds!.length,
          padding: EdgeInsets.only(
            left: size!.height * 0.0082,
            right: size!.height * 0.0082,
          ),
          itemBuilder: (context, index) {
            final Listed listed = vm.listeds![index];
            return ContextMenuRegion(
              contextMenu: GenericContextMenu(
                buttonConfigs: [
                  ContextMenuButtonConfig(
                    tr.deleteList,
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => vm.deleteList(context, listed),
                  ),
                ],
              ),
              child: ListedItem(
                listed: listed,
                height: size!.height,
                onPressed: () {
                  vm.localStorage.listed = vm.setListed = listed;
                  vm.navigator.goToSongEditorPc();
                  //vm.openListView(listed)
                },
              ),
            );
          },
        ),
      ),
    );

    var mainContainer = SizedBox(
      child: vm.isBusy
          ? const ListLoading()
          : vm.listeds!.isNotEmpty
              ? listContainer
              : NoDataToShow(
                  title: tr.itsEmptyHere1,
                  description: tr.itsEmptyHereBody4,
                ),
    );

    return Scaffold(
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
          padding: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, ThemeColors.accent, Colors.black],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleContainer,
                mainContainer,
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: ThemeColors.primary,
          onPressed: () => newListForm(context),
          child: const Icon(Icons.add, color: Colors.white),
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
