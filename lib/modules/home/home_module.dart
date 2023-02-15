import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/modules/home/domain/bloc/home_bloc.dart';
import 'package:my_vocation_app/modules/home/infra/repositories/home_repository.dart';
import 'package:provider/provider.dart';

final homeDependencies = [
  Provider<HomeRepository>(
    create: (context) => HomeRepository(context.read()),
  ),
  BlocProvider<HomeBloc>(
    create: (context) => HomeBloc(context.read()),
  ),
];
