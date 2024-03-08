import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';

class PrevNextBtn extends StatelessWidget {
  final int totalQuestions;
  final int index;
  final bool isLastQuestion;
  final VoidCallback nextQuestion;
  final VoidCallback prevQuestion;
  final VoidCallback quizSubmission;
  const PrevNextBtn({
    super.key,
    required this.totalQuestions,
    required this.index,
    required this.nextQuestion,
    required this.prevQuestion,
    required this.isLastQuestion,
    required this.quizSubmission,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            foregroundColor: AppColor.marianBlue,
          ),
          onPressed: () {
            prevQuestion();
          },
          child: const Row(
            children: [
              Icon(
                LucideIcons.arrowLeftCircle,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Prev\nQuestion"),
            ],
          ),
        ),
        (isLastQuestion)
            ? TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: AppColor.marianBlue,
                ),
                onPressed: () {
                  quizSubmission();
                },
                child: const Row(
                  children: [
                    Text(
                      "Quiz\nSubmission",
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      LucideIcons.arrowRightCircle,
                    ),
                  ],
                ),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: AppColor.marianBlue,
                ),
                onPressed: () {
                  nextQuestion();
                },
                child: const Row(
                  children: [
                    Text(
                      "Next\nQuestion",
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      LucideIcons.arrowRightCircle,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
