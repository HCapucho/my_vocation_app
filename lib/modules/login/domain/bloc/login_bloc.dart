import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocation_app/modules/login/domain/models/usuario.dart';
import 'package:my_vocation_app/modules/login/infra/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginAuthenticationEvent>(_authentication);
  }

  FutureOr<void> _authentication(
      LoginAuthenticationEvent event, Emitter<LoginState> emit) async {
    emit(LoginAuthenticationInProgress());
    final response =
        await loginRepository.login(user: event.user, password: event.password);

    if (response.isError()) {
      emit(LoginAuthenticationFailure(response.errorMessage!));
    } else if (response.isSuccessResponse()) {
      emit(LoginAuthenticationSuccess(response.requiresBody));
    }
  }
}
