part of '../home_screen.dart';

/// Tab screen with list of song drafts
// ignore: must_be_immutable
class DraftsTab extends StatelessWidget {
  final HomeVm vm;
  DraftsTab(this.vm, {Key? key}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;

    var listContainer = ListView.builder(
      padding: EdgeInsets.all(
        size!.height * 0.015,
      ),
      itemBuilder: (context, index) {
        final Draft draft = vm.drafts![index];
        return DraftItem(
          draft: draft,
          height: size!.height,
          onPressed: () {
            vm.localStorage.draft = vm.setDraft = draft;
            vm.navigator.goToDraftPresentor();
          },
        );
      },
      itemCount: vm.drafts!.length,
    );

    return Scaffold(
      backgroundColor: ThemeColors.backgroundGrey,
      body: SizedBox(
        height: size!.height,
        child: vm.isBusy
            ? const ListLoading()
            : vm.drafts!.isNotEmpty
                ? listContainer
                : NoDataToShow(
                    title: tr.itsEmptyHere,
                    description: tr.itsEmptyHereBody2,
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        onPressed: () => vm.navigator.goToDraftEditor(true),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
