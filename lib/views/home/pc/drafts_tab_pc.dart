part of '../home_screen.dart';

class DraftsTabPc extends StatelessWidget {
  final HomeVm vm;
  const DraftsTabPc(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    var listContainer = ListView.builder(
      padding: EdgeInsets.all(
        size.height * 0.015,
      ),
      itemBuilder: (context, index) {
        final Draft draft = vm.drafts![index];
        return DraftItem(
          draft: draft,
          height: size.height,
          onPressed: () => vm.chooseDraft(draft),
        );
      },
      itemCount: vm.drafts!.length,
    );

    var itemViewer = Scaffold(
      backgroundColor: ThemeColors.backgroundGrey,
      appBar: AppBar(
        elevation: 8,
        title: Text(vm.setDraft.title != null
            ? vm.setDraft.title!
            : 'No Selected Draft'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.copy),
            ),
          ),
          InkWell(
            onTap: vm.navigator.goToDraftPresentorPc,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(ThemeAssets.iconProject,
                    height: 30, width: 30)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: vm.versesDraft.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              vm.versesDraft[index].replaceAll("#", "\n"),
              style: TextStyle(fontSize: size.height * 0.03),
            ).padding(all: 10),
          );
        },
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vm.drafts!.isNotEmpty
            ? listContainer.expanded()
            : NoDataToShow(
                title: tr.itsEmptyHere,
                description: tr.itsEmptyHereBody2,
              ),
        if (vm.setDraft.title != null)
          itemViewer.decorated(
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ).expanded(),
      ],
    );
  }
}
