import 'package:flutter/material.dart';

class QuizController {
  final currentPageNotifier = ValueNotifier<int>(0);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int countResultAnswers = 0;
}
