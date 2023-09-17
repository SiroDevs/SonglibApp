part of '../home_screen.dart';

class SearchTabPc extends StatelessWidget {
  final HomeVm vm;
  const SearchTabPc(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    var listContainer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: vm.filtered!.length,
        padding: EdgeInsets.only(
          left: size.height * 0.0082,
          right: size.height * 0.0082,
        ),
        itemBuilder: (context, index) {
          final SongExt song = vm.filtered![index];
          return ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  tr.likeSong,
                  icon: Icon(
                    song.liked! ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                  ),
                  onPressed: () => vm.likeSong(song),
                ),
                ContextMenuButtonConfig(
                  tr.copySong,
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () => vm.copySong(song),
                ),
                ContextMenuButtonConfig(
                  tr.shareSong,
                  icon: const Icon(Icons.share, size: 20),
                  onPressed: () => vm.shareSong(song),
                ),
                ContextMenuButtonConfig(
                  tr.editSong,
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    vm.localStorage.song = vm.setSong = song;
                    vm.navigator.goToSongEditorPc();
                  },
                ),
                ContextMenuButtonConfig(
                  tr.addtoList,
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return ListPopup(vm: vm, song: song);
                    },
                  ),
                ),
              ],
            ),
            child: SongItem(
              song: song,
              isSelected: vm.setSong == song,
              isSearching: vm.isSearching,
              height: size.height,
              onPressed: () => vm.chooseSong(song),
            ),
          );
        },
      ),
    );
    var itemViewer = Scaffold(
      backgroundColor: ThemeColors.backgroundGrey,
      appBar: AppBar(
        elevation: 8,
        title: Text(vm.songTitle),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.copy),
            ),
          ),
          InkWell(
            onTap: () => vm.likeSong(vm.setSong),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(vm.setSong.liked ?? false
                  ? Icons.favorite
                  : Icons.favorite_border),
            ),
          ),
          InkWell(
            onTap: vm.navigator.goToSongPresentorPc,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(ThemeAssets.iconProject,
                    height: 30, width: 30)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: vm.verses.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              vm.verses[index].replaceAll("#", "\n"),
              style: TextStyle(fontSize: size.height * 0.03),
            ).padding(all: 10),
          );
        },
      ),
    );

    return Stack(
      children: [
        SizedBox(
          height: size.height - 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listContainer.expanded(),
              if (vm.setSong.title != null)
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
          ),
        ).padding(top: 100),
        vm.books!.isNotEmpty ? BooksContainer(vm) : ManageBooksBtn(vm),
      ],
    );
  }
}
