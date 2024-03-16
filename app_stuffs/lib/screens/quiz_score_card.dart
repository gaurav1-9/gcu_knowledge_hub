import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/headings.dart';
import '../widgets/quiz_info.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/quiz_score_card_detailed_score.dart';

enum QuestionStatus {
  correct,
  wrong,
  unanswered,
}

class QuizScoreCard extends StatefulWidget {
  final int totalQuestions;
  final List<String> selectedQuestions;
  final List<String> correctAnswers;
  final String subName;
  final Map<String, dynamic> quizQuestions;

  const QuizScoreCard({
    super.key,
    required this.totalQuestions,
    required this.selectedQuestions,
    required this.correctAnswers,
    required this.subName,
    required this.quizQuestions,
  });

  @override
  State<QuizScoreCard> createState() => _QuizScoreCardState();
}

class _QuizScoreCardState extends State<QuizScoreCard> {
  late int correctlyAnswered = 0;
  late int wrongAns = 0;
  late int timeLeft;
  late int unanswered = 0;
  late int totalQuestions;
  late String subName;
  late double percentage;
  late Map<String, dynamic> quizQuestions;
  late List<String> selectedQuestions;
  late List<String> correctAnswers;
  bool showDetailedResult = false;
  QuestionStatus isCorrect = QuestionStatus.unanswered;

  @override
  void initState() {
    super.initState();
    totalQuestions = widget.totalQuestions;
    selectedQuestions = widget.selectedQuestions;
    correctAnswers = widget.correctAnswers;
    quizQuestions = widget.quizQuestions;
    subName = widget.subName;

    for (var i = 0; i < totalQuestions; i++) {
      if (selectedQuestions[i] == "") {
        unanswered++;
      } else if (selectedQuestions[i] == correctAnswers[i]) {
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
                    subName,
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                        height: 10,
                      ),
                      (!showDetailedResult)
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  showDetailedResult = true;
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.chevronDown,
                                      size: 17,
                                      color: AppColor.marianBlue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "View detailed result",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppColor.marianBlue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : DetailedQuestionAnswer(
                              correctAnswers: correctAnswers,
                              quizQuestions: quizQuestions,
                              selectedQuestions: selectedQuestions,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      (showDetailedResult)
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  showDetailedResult = false;
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.chevronUp,
                                      size: 17,
                                      color: AppColor.marianBlue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "View confined result",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppColor.marianBlue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: TextButton(
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
      ),
    );
  }
}
