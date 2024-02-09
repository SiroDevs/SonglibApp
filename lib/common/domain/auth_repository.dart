import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../common/utils/logger.dart';

enum AuthStatus { authenticated, guest,  unauthenticated }

@singleton
class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    // alter this to authenticated to skip navigation to auth screen
    // be sure to return this to guest when pushing to production
    yield AuthStatus.guest;
    yield* _controller.stream;
  }

  Future<void> signUp() async {
    logger.i("User auth status: Unverified");
    await Future.delayed(
      const Duration(seconds: 2),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  Future<void> logIn() async {
    logger.i("User auth status: Authenticated");
    await Future.delayed(
      const Duration(seconds: 2),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  Future<void> logOut() async {
    logger.i("User auth status: Unauthenticated");
    await Future.delayed(
      const Duration(seconds: 2),
      () => _controller.add(AuthStatus.guest),
    );
  }

  void dispose() => _controller.close();
}
