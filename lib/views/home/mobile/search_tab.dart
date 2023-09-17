part of '../home_screen.dart';

/// Tab screen for searches
// ignore: must_be_immutable
class SearchTab extends StatelessWidget {
  final HomeVm vm;
  SearchTab(this.vm, {Key? key}) : super(key: key);
  Size? size;

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    size = MediaQuery.of(context).size;
    var listContainer = ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: vm.filtered!.length,
      padding: EdgeInsets.only(
        left: size!.height * 0.0082,
        right: size!.height * 0.0082,
      ),
      itemBuilder: (context, index) {
        final SongExt song = vm.filtered![index];
        return ContextMenuRegion(
          contextMenu: GenericContextMenu(
            buttonConfigs: [
              // Provides a way to like a song and add it to liked songs tab
              ContextMenuButtonConfig(
                tr.likeSong,
                icon: Icon(
                  song.liked! ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                ),
                onPressed: () => vm.likeSong(song),
              ),
              // Provides a way to copy the song title and number to clipboard
              ContextMenuButtonConfig(
                tr.copySong,
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () => vm.copySong(song),
              ),
              // Displays a context menu to share the song title and number
              ContextMenuButtonConfig(
                tr.shareSong,
                icon: const Icon(Icons.share, size: 20),
                onPressed: () => vm.shareSong(song),
              ),
              // Displays an option to edit the song
              ContextMenuButtonConfig(
                tr.editSong,
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  vm.localStorage.song = vm.setSong = song;
                  vm.navigator.goToSongEditor();
                },
              ),
              // Diplays a context menu to share, edit and copy a song
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
          // displays song item and navigates to song presenter upon pressing
          child: SongItem(
            song: song,
            height: size!.height,
            onPressed: () {
              vm.localStorage.song = vm.setSong = song;
              vm.navigator.goToSongPresentor();
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
          height: size!.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                vm.books!.isNotEmpty ? BooksContainer(vm) : ManageBooksBtn(vm),
                SizedBox(
                  child: vm.isBusy
                      ? const ListLoading()
                      : vm.songs!.isNotEmpty
                          ? listContainer
                          : NoDataToShow(
                              title: tr.itsEmptyHere,
                              description: tr.itsEmptyHereBody,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        onPressed: () async {
          await showSearch(
            context: context,
            delegate: SearchSongs(context, vm, size!.height),
          );
        },
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
