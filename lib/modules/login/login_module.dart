import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/modules/login/domain/bloc/login_bloc.dart';
import 'package:my_vocation_app/modules/login/infra/repositories/login_repository.dart';
import 'package:provider/provider.dart';

final loginDependencies = [
  Provider<LoginRepository>(
    create: (context) => LoginRepository(context.read()),
  ),
  BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(context.read()),
  ),
];
