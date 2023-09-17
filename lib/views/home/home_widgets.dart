part of 'home_screen.dart';

/// Action button 1
class ActionBtn1 extends StatelessWidget {
  final HomeVm? vm;
  const ActionBtn1(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (vm!.setPage) {
      case PageType.lists:
        return TextButton(
          onPressed: () => newListForm(context, vm!),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.add),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'ADD A LIST',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );

      case PageType.search:
      case PageType.likes:
      case PageType.helpdesk:
      case PageType.settings:
        return const SizedBox.shrink();

      case PageType.drafts:
        return TextButton(
          onPressed: () => vm!.navigator.goToDraftEditor(true),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.add),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'DRAFT A SONG',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}

/// Manage Song Books Container
class BooksContainer extends StatelessWidget {
  final HomeVm vm;
  const BooksContainer(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
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
            padding: const EdgeInsets.all(3),
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
          ManageBooksBtn(vm),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

/// Manage Song Books
class ManageBooksBtn extends StatelessWidget {
  final HomeVm? vm;
  final bool isClicked;
  const ManageBooksBtn(
    this.vm, {
    Key? key,
    this.isClicked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: RawMaterialButton(
        textStyle: TextStyles.Callout.size(16).textColor(Colors.white),
        fillColor: ThemeColors.error,
        highlightColor: Colors.white.withOpacity(.1),
        focusElevation: 0,
        hoverColor: ThemeColors.primary,
        hoverElevation: 1,
        highlightElevation: 0,
        elevation: 3,
        padding: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: ThemeColors.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () => MainNavigator.of(context).goToSelection(),
        child: SizedBox(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.settings),
              ),
              const Text(
                'MANAGE YOUR BOOK COLLECTION',
                maxLines: 3,
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDesktop;
  final HomeVm vm;
  final Size size;
  final PreferredSizeWidget? bottom;

  const HomeAppbar({
    super.key,
    this.isDesktop = false,
    required this.vm,
    required this.size,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(isDesktop ? 55 : 90);

  @override
  Widget build(BuildContext context) {
    var appBarMenu = PopupMenuButton<int>(
      initialValue: 0,
      // Callback that sets the selected popup menu item.
      onSelected: (int menu) {
        switch (menu) {
          case 1:
            MainNavigator.of(context).goToHelpDesk();
            break;

          case 2:
            MainNavigator.of(context).goToOnboarding();
            break;

          case 3:
            MainNavigator.of(context).goToDonation();
            break;

          case 4:
            MainNavigator.of(context).goToSelection();
            break;

          case 5:
            MainNavigator.of(context).goToSettings();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Our HelpDesk'),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text('How it Works'),
        ),
        if (vm.dateDiff > 2)
          const PopupMenuItem<int>(
            value: 3,
            child: Text('Make a Donation'),
          ),
        const PopupMenuItem<int>(
          value: 4,
          child: Text('Manage SongBooks'),
        ),
        const PopupMenuItem<int>(
          value: 5,
          child: Text('Manage Settings'),
        ),
      ],
    );

    var mobileAppbar = AppBar(
      title: Row(
        children: [
          Image.asset(ThemeAssets.appIcon, height: 35, width: 35),
          const SizedBox(width: 10),
          const Text(
            AppConstants.appTitle,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      actions: <Widget>[
        InkWell(
          onTap: () async {
            await showSearch(
              context: context,
              delegate: SearchSongs(context, vm, size.height),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search),
          ),
        ),
        /*InkWell(
          onTap: () {
            if (vm.isLoggedIn) {
              goToUser();
            } else {
              goToSignin();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.person),
          ),
        ),*/
        appBarMenu,
      ],
      bottom: bottom,
    );

    var desktopAppbar = AppBar(
      title: Row(
        children: [
          const SizedBox(width: 10),
          Image.asset(ThemeAssets.appIcon, height: 35, width: 35),
          const SizedBox(width: 10),
          const Text(
            '${AppConstants.appTitle} ${AppConstants.appVersion}',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(width: 60),
          vm.setPage == PageType.helpdesk || vm.setPage == PageType.settings
              ? const SizedBox.shrink()
              : SearchWidget(
                  onSearch: (query) => vm.onSearch(query),
                  searchController: vm.searchController,
                ),
          const SizedBox(width: 10),
        ],
      ),
      actions: <Widget>[
        ActionBtn1(vm),
        /*const SizedBox(width: 0),
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.notifications),
          ),
        ),*/
        const SizedBox(width: 20),
      ],
    );

    return isDesktop ? desktopAppbar : mobileAppbar;
  }
}
