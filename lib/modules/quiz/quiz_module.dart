import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/modules/quiz/domain/bloc/quiz_bloc.dart';
import 'package:my_vocation_app/modules/quiz/infra/repositories/quiz_repository.dart';
import 'package:provider/provider.dart';

final quizDependencies = [
  Provider<QuizRepository>(
    create: (context) => QuizRepository(context.read()),
  ),
  BlocProvider<QuizBloc>(
    create: (context) => QuizBloc(context.read()),
  ),
];
