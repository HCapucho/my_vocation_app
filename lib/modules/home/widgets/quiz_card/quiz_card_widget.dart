import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/shared/widgets/progress_indicator/progress_indicator_widget.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final int numberOfQuestions;
  final VoidCallback onTap;
  const QuizCardWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.numberOfQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.fromBorderSide(BorderSide(color: AppColors.border)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(AppImages.blocks),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.heading18,
            ),
            SizedBox(height: 20),
            Text("$numberOfQuestions questões", style: AppTextStyles.body15),
          ],
        ),
      ),
    );
  }
}
