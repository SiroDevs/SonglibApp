part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.statusChanged(
      AuthStatus status) = AuthStatusChanged;
  const factory AuthEvent.logoutRequested() =
      AuthLogoutRequested;
}
