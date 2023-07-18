part of '../home_screen.dart';

class ListTabPc extends StatefulWidget {
  final HomeVm vm;
  const ListTabPc(this.vm, {super.key});

  @override
  ListTabPcState createState() => ListTabPcState();
}

class ListTabPcState extends State<ListTabPc> {
  TextEditingController qryController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void onFocusChange() {
    setState(() => isSearching = focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    HomeVm vm = widget.vm;

    var listContainer = ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.vm.listeds!.length,
      padding: EdgeInsets.only(
        left: size.height * 0.0082,
        right: size.height * 0.0082,
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
            onPressed: () => vm.chooseListed(listed),
          ),
        );
      },
    );
    var subListContainer = ListView.builder(
      itemCount: vm.listSongs!.length,
      padding: EdgeInsets.all(
        size.height * 0.0082,
      ),
      itemBuilder: (ctx, index) {
        final SongExt song = vm.listSongs![index];
        return SongItem(
          song: song,
          isSearching: true,
          height: size.height,
          onPressed: () {
            vm.localStorage.song = vm.setSong = song;
            vm.navigator.goToSongPresentorPc();
          },
        );
      },
    );
    var itemViewer = Scaffold(
      backgroundColor: ThemeColors.backgroundGrey,
      appBar: AppBar(
        elevation: 8,
        title: Text(vm.setListed.title != null
            ? vm.setListed.title!
            : 'No Selected List'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.edit),
            ),
          ),
          InkWell(
            onTap: () => vm.deleteList(context, vm.setListed),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.delete),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          vm.isMiniLoading
              ? Container()
              : vm.listedSongs!.isNotEmpty
                  ? subListContainer
                  : NoDataToShow(
                      title: tr.itsEmptyHere,
                      description: tr.itsEmptyHereBody,
                    ),
          isSearching
              ? FloatingSearch(
                  items: vm.songs!,
                  focus: focusNode,
                  onPressed: (song) => vm.addSongToList(song),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        onPressed: () => setState(() => isSearching = !isSearching),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    ).decorated(
      boxShadow: [
        const BoxShadow(
          color: Colors.grey,
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listContainer.expanded(),
        if (vm.setListed.title != null) itemViewer.expanded(),
      ],
    );
  }

  Future<void> editListForm(BuildContext context, HomeVm vm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Update This List',
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
              vm.saveListChanges();
              vm.titleController!.clear();
              vm.contentController!.clear();
              Navigator.pop(context);
            },
            child: const Text("SAVE CHANGES"),
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
