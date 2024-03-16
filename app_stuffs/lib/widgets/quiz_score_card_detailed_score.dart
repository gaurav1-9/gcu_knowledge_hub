import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../screens/quiz_score_card.dart';

class DetailedQuestionAnswer extends StatelessWidget {
  final Map<String, dynamic> quizQuestions;
  final List<String> selectedQuestions;
  final List<String> correctAnswers;
  const DetailedQuestionAnswer({
    super.key,
    required this.quizQuestions,
    required this.selectedQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    QuestionStatus isCorrect;
    int qNo = 0;
    return Column(
      children: quizQuestions.entries.map((entry) {
        if (selectedQuestions[qNo] == correctAnswers[qNo]) {
          isCorrect = QuestionStatus.correct;
        } else if (selectedQuestions[qNo] == "") {
          isCorrect = QuestionStatus.unanswered;
        } else {
          isCorrect = QuestionStatus.wrong;
        }
        qNo++;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Question ",
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      (qNo < 10)
                          ? TextSpan(text: "0$qNo")
                          : TextSpan(text: "$qNo"),
                    ],
                  ),
                ),
                (isCorrect == QuestionStatus.correct)
                    ? const Icon(
                        LucideIcons.checkCircle2,
                        color: AppColor.forestGreen,
                      )
                    : (isCorrect == QuestionStatus.wrong)
                        ? const Icon(
                            LucideIcons.xCircle,
                            color: AppColor.tomato,
                          )
                        : const Icon(
                            LucideIcons.helpCircle,
                            color: AppColor.jonquil,
                          )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    entry.value['qName'],
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Option",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 26,
                ),
                const Text(
                  ":",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                (isCorrect == QuestionStatus.unanswered)
                    ? const Text(
                        "Unanswered",
                        style: TextStyle(
                          color: AppColor.marianBlue,
                        ),
                      )
                    : Expanded(
                        child: Text(
                          "(${selectedQuestions[qNo - 1]}) ${entry.value['choice'][selectedQuestions[qNo - 1]]}",
                          style: const TextStyle(
                            color: AppColor.marianBlue,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Correct Option :",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "(${correctAnswers[qNo - 1]}) ${entry.value['choice'][correctAnswers[qNo - 1]]}",
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }).toList(),
    );
  }
}
