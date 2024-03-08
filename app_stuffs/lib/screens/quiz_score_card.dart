import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizScoreCard extends StatefulWidget {
  final int totalQuestions;
  final List selectedQuestions;
  final List correctAnswers;

  const QuizScoreCard({
    super.key,
    required this.totalQuestions,
    required this.selectedQuestions,
    required this.correctAnswers,
  });

  @override
  State<QuizScoreCard> createState() => _QuizScoreCardState();
}

class _QuizScoreCardState extends State<QuizScoreCard> {
  late int correctlyAnswered = 0;
  late int wrongAns = 0;
  late int unanswered = 0;
  late int totalQuestions;

  @override
  void initState() {
    super.initState();
    totalQuestions = widget.totalQuestions;
    for (var i = 0; i < totalQuestions; i++) {
      if (widget.selectedQuestions[i] == "") {
        unanswered++;
      } else if (widget.selectedQuestions[i] == widget.correctAnswers[i]) {
        correctlyAnswered++;
      } else {
        wrongAns++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 1,
        leading: const AppBarBackBtn(),
        title: const GCUTextLogo(
          size: 60,
          fontSize: 16,
          alignment: MainAxisAlignment.start,
        ),
        backgroundColor: AppColor.jonquil,
      ),
      body: Column(
        children: [
          const Text(
            "Well Done!!",
          ),
          Text("Total questions: ${totalQuestions.toString()}"),
          Text("Unanswered: $unanswered"),
          Text("Correct: $correctlyAnswered"),
          Text("wrong: $wrongAns"),
        ],
      ),
    );
  }
}
