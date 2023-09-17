part of 'selection_screen.dart';

/// Song book selection screen
class SelectionPage extends StatelessWidget {
  final SelectionVm vm;
  const SelectionPage(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    bool isTabletOrIpad = size.shortestSide > 550;
    var topContainer = AppBar(
      title: Text(
        vm.isBusy ? tr.booksTitleLoading : tr.booksTitle,
      ),
      actions: <Widget>[
        vm.isBusy
            ? const SizedBox.shrink()
            : InkWell(
                onTap: vm.fetchBooks,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.refresh),
                ),
              ),
        vm.isBusy
            ? const SizedBox.shrink()
            : vm.hasError
                ? const SizedBox.shrink()
                : IconTextBtn(
                    onPressed: () => areYouDoneDialog(context, vm),
                    title: tr.proceed,
                  ),
      ],
    );

    var bigScreenLayout = LayoutBuilder(
      builder: (context, dimens) {
        int axisCount = (dimens.maxWidth / 450).round();
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount,
            childAspectRatio: 4,
          ),
          itemCount: vm.books!.length,
          itemBuilder: (context, index) => BookItem(
            book: vm.books![index],
            selected: vm.listedBooks[index]!.isSelected,
            onPressed: () => vm.onBookSelected(index),
          ),
        );
      },
    );
    var smallScreenLayout = ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: vm.books!.length,
      itemBuilder: (context, index) => BookItem(
        book: vm.books![index],
        selected: vm.listedBooks[index]!.isSelected,
        onPressed: () => vm.onBookSelected(index),
      ),
    );

    return Scaffold(
      appBar: topContainer,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              vm.isBusy
                  ? const CircularProgress()
                  : vm.books!.isNotEmpty
                      ? isDesktop || isMobile && isTabletOrIpad
                          ? bigScreenLayout
                          : smallScreenLayout
                      : const SizedBox.shrink(),
              if (vm.failure) ...[
                ResponseFeedback(
                    isSuccess: false,
                    title: vm.feedbackTitle,
                    message: vm.feedbackMessage),
              ],
              if (vm.success) ...[
                ResponseFeedback(
                    title: vm.feedbackTitle, message: vm.feedbackMessage),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: vm.isBusy
          ? const SizedBox.shrink()
          : vm.hasError
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  backgroundColor: ThemeColors.primary,
                  onPressed: () => areYouDoneDialog(context, vm),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
    );
  }
}
