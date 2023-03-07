import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/modules/quiz/infra/repositories/quiz_repository.dart';
import 'package:my_vocation_app/modules/result/domain/bloc/result_bloc.dart';
import 'package:provider/provider.dart';

final resultDependencies = [
  Provider<QuizRepository>(
    create: (context) => QuizRepository(context.read()),
  ),
  BlocProvider<ResultBloc>(
    create: (context) => ResultBloc(context.read()),
  ),
];
