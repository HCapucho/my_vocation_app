import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/pergunta.dart';
import 'package:my_vocation_app/modules/quiz/widgets/answer/answer_widget.dart';

class QuizWidget extends StatefulWidget {
  final Pergunta question;
  final Function(int, int) onTap;
  const QuizWidget({
    Key? key,
    required this.question,
    required this.onTap,
  }) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 64),
        Text(
          widget.question.titulo,
          style: AppTextStyles.heading,
        ),
        SizedBox(height: 24),
        AnswerWidget(
          answerValue: 1,
          answerTitle: "Não representa",
          isSelected: selectedIndex == 1,
          onTap: (value) {
            selectedIndex = 1;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 2,
          answerTitle: "Me representa mal",
          isSelected: selectedIndex == 2,
          onTap: (value) {
            selectedIndex = 2;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 3,
          answerTitle: "Quase não me representa",
          isSelected: selectedIndex == 3,
          onTap: (value) {
            selectedIndex = 3;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 4,
          answerTitle: "Indiferente",
          isSelected: selectedIndex == 4,
          onTap: (value) {
            selectedIndex = 4;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 5,
          answerTitle: "Me representa pouco",
          isSelected: selectedIndex == 5,
          onTap: (value) {
            selectedIndex = 5;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 6,
          answerTitle: "Me representa bem",
          isSelected: selectedIndex == 6,
          onTap: (value) {
            selectedIndex = 6;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
        AnswerWidget(
          answerValue: 7,
          answerTitle: "Me representa muito bem",
          isSelected: selectedIndex == 7,
          onTap: (value) {
            selectedIndex = 7;
            setState(() {});
            Future.delayed(Duration(seconds: 1))
                .then((_) => widget.onTap(value, widget.question.id));
          },
        ),
      ],
    );
  }
}
