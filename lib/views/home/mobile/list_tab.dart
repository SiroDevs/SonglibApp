part of '../home_screen.dart';

/// Tab screen with list of song lists
// ignore: must_be_immutable
class ListTab extends StatelessWidget {
  final HomeVm vm;
  ListTab(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    var listContainer = ListView.builder(
      itemCount: vm.listeds!.length,
      padding: EdgeInsets.all(
        size.height * 0.015,
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
            height: size.height,
            onPressed: () {
              vm.localStorage.listed = vm.setListed = listed;
              MainNavigator.of(context).goToListView();
            },
          ),
        );
      },
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
          height: size.height,
          child: vm.isBusy
              ? const ListLoading()
              : vm.listeds!.isNotEmpty
                  ? listContainer
                  : NoDataToShow(
                      title: tr.itsEmptyHere1,
                      description: tr.itsEmptyHereBody4,
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        onPressed: () => newListForm(context, vm),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
