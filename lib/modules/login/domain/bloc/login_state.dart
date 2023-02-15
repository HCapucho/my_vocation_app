part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginAuthenticationInProgress extends LoginState {}

class LoginAuthenticationFailure extends LoginState {
  final String errorMessage;

  LoginAuthenticationFailure(this.errorMessage);
}

class LoginAuthenticationSuccess extends LoginState {
  final Usuario usuario;

  LoginAuthenticationSuccess(this.usuario);
}
