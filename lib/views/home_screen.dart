import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:songlib/utils/constants/app_constants.dart';

import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

@visibleForTesting
class HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => GetIt.I()..init(this),
      child: Consumer<HomeViewModel>(
        builder: (ctx, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppConstants.appName),
            ),
            body: const Center(
              child: SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
