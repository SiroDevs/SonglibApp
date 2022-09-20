import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../util/constants/app_constants.dart';
import '../../vm/lists/list_vm.dart';
import '../../widget/general/labels.dart';
import '../../widget/general/list_items.dart';
import '../../widget/progress/line_progress.dart';
import '../../widget/provider/provider_widget.dart';
import '../songs/presentor_screen.dart';

class ListViewScreen extends StatefulWidget {
  static const String routeName = RouteNames.listScreen;

  const ListViewScreen({Key? key}) : super(key: key);

  @override
  ListViewScreenState createState() => ListViewScreenState();
}

@visibleForTesting
class ListViewScreenState extends State<ListViewScreen>
    with BackNavigatorMixin
    implements ListNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return ProviderWidget<ListVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization: (
        context,
        viewModel,
        child,
        theme,
        localization,
      ) =>
          screenWidget(context, viewModel),
    );
  }

  Widget screenWidget(BuildContext context, ListVm viewModel) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('aaaa'),
        title: Text(viewModel.listed!.title!),
        actions: <Widget>[
          InkWell(
            onTap: () => {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.edit),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: mainContainer(viewModel),
    );
  }

  Widget mainContainer(ListVm viewModel) {
    return Container(
      height: size!.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, ThemeColors.accent, Colors.black],
        ),
      ),
      child: SingleChildScrollView(
        child: viewModel.isBusy
            ? const ListLoading()
            : viewModel.likes!.isNotEmpty
                ? listContainer(viewModel)
                : const NoDataToShow(
                    title: AppConstants.itsEmptyHere,
                    description: AppConstants.itsEmptyHereBody,
                  ),
      ),
    );
  }

  Widget listContainer(ListVm viewModel) {
    return SizedBox(
      height: size!.height,
      child: Scrollbar(
        thickness: 10,
        radius: const Radius.circular(20),
        child: ListView.builder(
          itemCount: viewModel.likes!.length,
          padding: EdgeInsets.all(
            size!.height * 0.0082,
          ),
          itemBuilder: (context, index) => SongItem(
            song: viewModel.likes![index],
            height: size!.height,
            onTap: () => {},
          ),
        ),
      ),
    );
  }
}
