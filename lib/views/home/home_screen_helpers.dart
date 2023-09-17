part of 'home_screen.dart';

Future<void> newListForm(BuildContext context, HomeVm vm) async {
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
          onPressed: () async {
            if (vm.titleController!.text.isNotEmpty) {
              vm.isBusy = true;
              vm.rebuild();
              vm.setListed.title = vm.titleController!.text;
              vm.setListed.description = vm.contentController!.text;
              await vm.dbRepo.editListed(vm.setListed);
              showToast(
                text: '${vm.setListed.title} ${vm.tr!.listUpdated}',
                state: ToastStates.success,
              );
              vm.isBusy = false;
              vm.rebuild();
            }
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

Future<void> confirmDelete(BuildContext context, HomeVm vm) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(
        'Just a Minute',
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
        'Are you sure you want to delete the song list: ${vm.setListed.title}?',
        style: const TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            showToast(
              text: '${vm.setListed.title} ${vm.tr!.deleted}',
              state: ToastStates.success,
            );
            Navigator.pop(context);
            vm.dbRepo.removeListed(vm.setListed.id!);
            vm.fetchListedData();
          },
          child: const Text("DELETE"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("CANCEL"),
        ),
      ],
    ),
  );
}

/// Add a song to a list
Future<void> addSongToList(SongExt song, HomeVm vm) async {
  vm.isBusy = true;
  vm.rebuild();
  await vm.dbRepo.saveListedSong(vm.setListed, song);

  //await fetchData();
  showToast(
    text: '${song.title} ${vm.tr!.songAddedToList}',
    state: ToastStates.success,
  );
  vm.isBusy = false;
  vm.rebuild();
}
