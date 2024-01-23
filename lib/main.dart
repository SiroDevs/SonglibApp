import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'common/utils/logger.dart';

/// Main App Bloc Observer
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    logger.i('onTransition(${bloc.runtimeType}, $transition)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// App entry point: all global declarations are initialized here
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger.i('Starting app from main.dart');

  Bloc.observer = AppBlocObserver();
  runApp(const App());
}
