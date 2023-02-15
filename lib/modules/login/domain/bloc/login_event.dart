part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginAuthenticationEvent extends LoginEvent {
  final String user;
  final String password;

  LoginAuthenticationEvent(this.user, this.password);
}
