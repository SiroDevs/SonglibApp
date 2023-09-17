import 'package:context_menus/context_menus.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../model/base/book.dart';
import '../../model/base/songext.dart';
import '../../theme/theme_assets.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_styles.dart';
import '../../utils/constants/app_constants.dart';
import '../../viewmodels/home/home_web_vm.dart';
import '../../widgets/action/sidebar.dart';
import '../../widgets/general/fading_index_stack.dart';
import '../../widgets/general/list_items.dart';
import '../../widgets/progress/line_progress.dart';
import '../../widgets/search/headers.dart';
import '../info/helpdesk_screen.dart';

part 'pc/search_tab_web.dart';

/// Home screen with 3 tabs of list, search and notes screens
class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  HomeScreenWebState createState() => HomeScreenWebState();
}

class HomeScreenWebState extends State<HomeScreenWeb>
    implements HomeWebNavigator {
  Size? size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<HomeWebVm>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<HomeWebVm>(
        builder: (ctx, vm, child) {
          vm.context = ctx;
          vm.tr = AppLocalizations.of(ctx)!;
          var desktopBody = Stack(
            children: [
              FadingIndexedStack(
                duration: Durations.slow,
                index: vm.pages.indexOf(vm.setPage),
                children: <Widget>[
                  SearchTabWeb(vm),
                  const HelpDeskScreen(),
                ],
              )
                  .positioned(
                      left: 300, right: 0, bottom: 0, top: 0, animate: true)
                  .animate(.35.seconds, Curves.bounceIn),
              Sidebar(
                isWeb: true,
                pageType: vm.setPage,
                onPageSelect: (page) => vm.setCurrentPage(page),
              )
                  .positioned(
                      left: 0, top: 0, bottom: 0, width: 300, animate: true)
                  .animate(.35.seconds, Curves.easeOut),
            ],
          );

          return Scaffold(
            appBar: AppBar(
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
                  SearchWidget(
                    onSearch: (query) => vm.onSearch(query),
                    searchController: vm.searchController,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            body: TweenAnimationBuilder<double>(
              duration: Durations.slow,
              tween: Tween(begin: 0, end: 1),
              builder: (_, value, ___) {
                return FocusTraversalGroup(child: desktopBody);
              },
            ),
          );
        },
      ),
    );
  }
}
