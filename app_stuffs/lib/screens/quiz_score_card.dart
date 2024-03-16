import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/headings.dart';
import '../widgets/quiz_info.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

enum QuestionStatus {
  correct,
  wrong,
  unanswered,
}

class QuizScoreCard extends StatefulWidget {
  final int totalQuestions;
  final List selectedQuestions;
  final List correctAnswers;
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
  late List selectedQuestions;
  late List correctAnswers;
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
    int qNo = 0;
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
                          : Column(
                              children: quizQuestions.entries.map((entry) {
                                if (selectedQuestions[qNo] ==
                                    correctAnswers[qNo]) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                            : (isCorrect ==
                                                    QuestionStatus.wrong)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
