part of '../home_screen_web.dart';

class SearchTabWeb extends StatelessWidget {
  final HomeWebVm vm;
  const SearchTabWeb(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    var booksContainer = Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 5),
      decoration: const BoxDecoration(
        color: ThemeColors.backgroundGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(5),
            itemBuilder: (context, index) {
              final Book book = vm.books![index];
              return SongBook(
                book: book,
                isSelected: vm.setBook == book,
                onPressed: () => vm.selectSongbook(book),
              );
            },
            itemCount: vm.books!.length,
          ).expanded(),
        ],
      ),
    );
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
                  tr.copySong,
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () => vm.copySong(song),
                ),
                ContextMenuButtonConfig(
                  tr.shareSong,
                  icon: const Icon(Icons.share, size: 20),
                  onPressed: () => vm.shareSong(song),
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

    return vm.isLoading
        ? const ListLoading()
        : Stack(
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
              booksContainer,
            ],
          );
  }
}
