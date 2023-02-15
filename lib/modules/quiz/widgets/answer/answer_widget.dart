import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';

class AnswerWidget extends StatelessWidget {
  final int answerValue;
  final String answerTitle;
  final bool isSelected;
  final bool disabled;
  final ValueChanged<int> onTap;
  const AnswerWidget({
    Key? key,
    this.isSelected = false,
    required this.answerValue,
    required this.answerTitle,
    required this.onTap,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IgnorePointer(
        ignoring: disabled,
        child: GestureDetector(
          onTap: () {
            onTap(answerValue);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.lightBlue : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.fromBorderSide(
                BorderSide(
                    color: isSelected ? AppColors.blue : AppColors.border),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(answerTitle,
                        style: isSelected
                            ? AppTextStyles.bodyDarkBlue
                            : AppTextStyles.body)),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.darkBlue : AppColors.white,
                    borderRadius: BorderRadius.circular(500),
                    border: Border.fromBorderSide(
                      BorderSide(
                          color: isSelected
                              ? AppColors.lightBlue
                              : AppColors.border),
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
