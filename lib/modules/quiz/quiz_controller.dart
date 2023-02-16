import 'package:flutter/material.dart';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';

class QuizController {
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  late List<RespostaQuestionarioDto> respostas = [];
}
