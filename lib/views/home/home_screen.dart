import 'package:context_menus/context_menus.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../model/base/book.dart';
import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/songext.dart';
import '../../model/general/general.dart';
import '../../navigator/main_navigator.dart';
import '../../theme/theme_assets.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/utilities.dart';
import '../../viewmodels/home/home_vm.dart';
import '../../widgets/action/sidebar.dart';
import '../../widgets/general/app_bar.dart';
import '../../widgets/general/fading_index_stack.dart';
import '../../widgets/general/labels.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/general/toast.dart';
import '../../widgets/inputs/form_input.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/progress/line_progress.dart';
import '../../widgets/search/floating_search.dart';
import '../../widgets/search/headers.dart';
import '../../widgets/search/search_list.dart';
import '../../widgets/search/search_songs.dart';

part 'home_screen_helpers.dart';
part 'home_widgets.dart';
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
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin
    implements HomeNavigator {
  late TabController tabController;
  Size? size;
  int? selectedMenu;
  bool isBigView = false;

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
    return ChangeNotifierProvider<HomeVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<HomeVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;
          isBigView = size!.width > PageBreaks.tabletLandscape;

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
                  //const HelpDeskScreen(),
                  //const SettingsScreen(),
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
          var tabBar = TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(text: 'Lists'.toUpperCase()),
              Tab(text: 'Search'.toUpperCase()),
              Tab(text: 'Likes'.toUpperCase()),
              Tab(text: 'Drafts'.toUpperCase()),
            ],
          );
          var mobileBody = TabBarView(
            controller: tabController,
            children: <Widget>[
              ListTab(vm),
              SearchTab(vm),
              LikesTab(vm),
              DraftsTab(vm),
            ],
          );

          return Scaffold(
            appBar: HomeAppbar(
              isDesktop: isDesktop && isBigView,
              vm: vm,
              size: size!,
              bottom: tabBar,
            ),
            body: TweenAnimationBuilder<double>(
              duration: Durations.slow,
              tween: Tween(begin: 0, end: 1),
              builder: (_, value, ___) {
                return FocusTraversalGroup(
                  child: isDesktop && isBigView ? desktopBody : mobileBody,
                );
              },
            ),
          );
        },
      ),
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
}
