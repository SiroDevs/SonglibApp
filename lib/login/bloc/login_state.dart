part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Username.pure()) Username username,
    @Default(Password.pure()) Password password,
    @Default(false) bool isValid,
  }) = _LoginState;

  
}
