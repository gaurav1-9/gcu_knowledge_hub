import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/headings.dart';
import 'package:gcu_knowledge_hub/widgets/quiz_info.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizScoreCard extends StatefulWidget {
  final int totalQuestions;
  final List selectedQuestions;
  final List correctAnswers;
  final String subName;

  const QuizScoreCard({
    super.key,
    required this.totalQuestions,
    required this.selectedQuestions,
    required this.correctAnswers,
    required this.subName,
  });

  @override
  State<QuizScoreCard> createState() => _QuizScoreCardState();
}

class _QuizScoreCardState extends State<QuizScoreCard> {
  late int correctlyAnswered = 0;
  late int wrongAns = 0;
  late int unanswered = 0;
  late int totalQuestions;
  late double percentage;

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
    percentage = ((correctlyAnswered / totalQuestions) * 100);
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Headings(
              primaryText: "Score",
              secondaryTextFirst: "C",
              secondaryText: "ard",
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Text(
                    widget.subName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.marianBlue,
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  QuizInfoBar(
                    value: totalQuestions,
                    desc: "Total Questions",
                  ),
                  QuizInfoBar(
                    value: correctlyAnswered,
                    desc: "Correct Answers",
                  ),
                  QuizInfoBar(
                    value: wrongAns,
                    desc: "Wrong Answers",
                  ),
                  QuizInfoBar(
                    value: unanswered,
                    desc: "Unanswered Questions",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            (percentage.toInt() >= 50)
                ? const Text(
                    "Well Done!!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.marianBlue,
                      fontSize: 25,
                    ),
                  )
                : const Text(
                    "Better luck next time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.marianBlue,
                      fontSize: 25,
                    ),
                  ),
            Text(
              "${percentage.toInt().toString()}%",
              style: const TextStyle(
                height: 1,
                fontSize: 90,
                color: AppColor.marianBlue,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/schools');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.rotateCcw,
                      size: 17,
                      color: AppColor.marianBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Take another quiz",
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColor.marianBlue,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
