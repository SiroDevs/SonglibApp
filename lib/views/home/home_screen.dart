import 'package:context_menus/context_menus.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../models/base/book.dart';
import '../../models/base/draft.dart';
import '../../models/base/listed.dart';
import '../../models/base/songext.dart';
import '../../models/general/general.dart';
import '../../navigator/main_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_assets.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/utilities.dart';
import '../../vms/home/home_vm.dart';
import '../../widgets/action/sidebar.dart';
import '../../widgets/general/app_bar.dart';
import '../../widgets/general/fading_index_stack.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/general/toast.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/progress/line_progress.dart';
import '../../widgets/provider/provider_widget.dart';
import '../../widgets/search/floating_search.dart';
import '../../widgets/search/headers.dart';
import '../../widgets/search/search_list.dart';
import '../../widgets/search/search_songs.dart';
import '../info/helpdesk_screen.dart';
import '../manage/settings_screen.dart';

part 'home_screen_helpers.dart';
part 'mobile/drafts_tab.dart';
part 'mobile/history_tab.dart';
part 'mobile/search_tab.dart';
part 'mobile/list_popup.dart';
part 'mobile/likes_tab.dart';
part 'mobile/list_tab.dart';
part 'pc/drafts_tab_pc.dart';
part 'pc/likes_tab_pc.dart';
part 'pc/list_tab_pc.dart';
part 'pc/search_tab_pc.dart';

/// Home screen with 3 tabs of list, search and notes screens
class HomeScreen extends StatefulWidget {
  static const String routeName = RouteNames.homeScreen;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin
    implements HomeNavigator {
  late TabController tabController;
  Size? size;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ProviderWidget<HomeVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (ctx, vm, child, theme, localization) {
        vm.context = ctx;
        vm.tr = AppLocalizations.of(ctx)!;
        int? selectedMenu;
        var appBarMenu = PopupMenuButton<int>(
          initialValue: selectedMenu,
          // Callback that sets the selected popup menu item.
          onSelected: (int menu) {
            switch (menu) {
              case 1:
                goToHelpDesk();
                break;

              case 2:
                goToOnboarding();
                break;

              case 3:
                goToDonation();
                break;

              case 4:
                goToSelection();
                break;

              case 5:
                goToSettings();
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
                  context: ctx,
                  delegate: SearchSongs(ctx, vm, size!.height),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.search),
              ),
            ),
            InkWell(
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
            ),
            appBarMenu,
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(text: 'Lists'.toUpperCase()),
              Tab(text: 'Search'.toUpperCase()),
              Tab(text: 'Likes'.toUpperCase()),
              Tab(text: 'Drafts'.toUpperCase()),
            ],
          ),
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
        var desktopBody = Stack(
          children: [
            FadingIndexedStack(
              duration: Durations.slow,
              index: vm.pages.indexOf(vm.setPage),
              children: <Widget>[
                ListTabPc(vm),
                SearchTabPc(vm),
                LikesTabPc(vm),
                DraftsTabPc(vm),
                const HelpDeskScreen(),
                const SettingsScreen(),
              ],
            )
                .positioned(
                    left: 300, right: 0, bottom: 0, top: 0, animate: true)
                .animate(.35.seconds, Curves.bounceIn),
            Sidebar(
              pageType: vm.setPage,
              onPageSelect: (page) => vm.setCurrentPage(page),
            )
                .positioned(
                    left: 0, top: 0, bottom: 0, width: 300, animate: true)
                .animate(.35.seconds, Curves.easeOut),
          ],
        );

        return Scaffold(
          appBar: isDesktop ? desktopAppbar : mobileAppbar,
          body: TweenAnimationBuilder<double>(
            duration: Durations.slow,
            tween: Tween(begin: 0, end: 1),
            builder: (_, value, ___) {
              return FocusTraversalGroup(
                child: isDesktop
                    ? desktopBody
                    : TabBarView(
                        controller: tabController,
                        children: <Widget>[
                          ListTab(vm),
                          SearchTab(vm),
                          LikesTab(vm),
                          DraftsTab(vm),
                        ],
                      ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void goToSongPresentor() => MainNavigator.of(context).goToSongPresentor();

  @override
  void goToSongPresentorPc() => MainNavigator.of(context).goToSongPresentorPc();

  @override
  void goToDraftPresentor() => MainNavigator.of(context).goToDraftPresentor();

  @override
  void goToDraftPresentorPc() =>
      MainNavigator.of(context).goToDraftPresentorPc();

  @override
  void goToSongEditor() => MainNavigator.of(context).goToSongEditor();

  @override
  void goToSongEditorPc() => MainNavigator.of(context).goToSongEditorPc();

  @override
  void goToDraftEditor(bool notEmpty) =>
      MainNavigator.of(context).goToDraftEditor(notEmpty);

  @override
  void goToListView() => MainNavigator.of(context).goToListView();

  @override
  void goToSettings() => MainNavigator.of(context).goToSettings();

  @override
  void goToSelection() => MainNavigator.of(context).goToSelection();

  @override
  void goToHelpDesk() => MainNavigator.of(context).goToHelpDesk();

  // Navigates to Donation screen
  @override
  void goToDonation() => MainNavigator.of(context).goToDonation();

  // Navigates to Onboarding screen
  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();

  @override
  void goToUser() => MainNavigator.of(context).goToUser();

  @override
  void goToSignin() => MainNavigator.of(context).goToSignin();

  @override
  void goToSignup() => MainNavigator.of(context).goToSignup();
}
