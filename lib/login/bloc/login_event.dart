part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  factory LoginEvent.usernameChanged(String username) =
      LoginUsernameChanged;
  factory LoginEvent.passwordChanged(String password) =
      LoginPasswordChanged;
  const factory LoginEvent.submitted() = LoginSubmitted;
}
