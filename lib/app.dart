import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/bloc/auth/auth_bloc.dart';
import 'common/domain/auth_repository.dart';
import 'common/navigator/main_navigator.dart';
import 'common/navigator/route_names.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthRepository _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepository();
  }

  @override
  void dispose() {
    _authRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: _authRepo),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: MainNavigatorState.initialRoute,
      onGenerateRoute: MainNavigatorState.onGenerateRoute,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                navigator.pushNamedAndRemoveUntil<void>(
                  RouteNames.home,
                  (route) => false,
                );
              case AuthStatus.unauthenticated:
                navigator.pushNamedAndRemoveUntil<void>(
                  RouteNames.login,
                  (route) => false,
                );
              case AuthStatus.guest:
                /*navigator.pushNamedAndRemoveUntil<void>(
                  RouteNames.home,
                  (route) => false,
                );*/
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
