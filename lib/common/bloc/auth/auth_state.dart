part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState._({
    @Default(AuthStatus.guest) AuthStatus status,
  }) = _AuthState;
}

extension XAuthState on AuthState {
  static AuthState unauthenticated() => AuthState._(
        status: AuthStatus.unauthenticated,
      );
  static AuthState authenticated() => AuthState._(
        status: AuthStatus.authenticated,
      );
  static AuthState guest() => AuthState._(
        status: AuthStatus.guest,
      );
}
