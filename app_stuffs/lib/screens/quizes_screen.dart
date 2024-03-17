import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/screens/circular_loading_screen.dart';
import 'package:http/http.dart' as http;

import '../screens/quiz_score_card.dart';
import '../widgets/prev_next_btns.dart';
import '../widgets/question_no_timer_displayer.dart';
import '../widgets/quiz_info.dart';
import '../widgets/quiz_timeout_widget.dart';
import '../widgets/under_development.dart';
import '../widgets/subjects_heading.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizesScreen extends StatefulWidget {
  final String branchID;
  final String schID;
  final String subID;
  final String subName;
  const QuizesScreen({
    super.key,
    required this.branchID,
    required this.schID,
    required this.subID,
    required this.subName,
  });

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  bool isLoading = true;
  bool isUnderDevelopment = false;
  late String subName;
  late Map<String, dynamic> quizQuestions;
  List<String> selectedOptions = [];
  List<String> quizAnswers = [];
  int index = 0;

  late Timer quizTimer;
  late int countDownTimer;

  bool isLastQuestion = false;

  void getQuestions() async {
    String questionURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/${widget.schID}/branchNames/${widget.branchID}/subjects/${widget.subID}/questions.json";
    final response = await http.get(Uri.parse(questionURL));
    try {
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData != null) {
          setState(() {
            quizQuestions = Map<String, dynamic>.from(decodedData);
            selectedOptions = List.filled(quizQuestions.length, '');
            if (quizQuestions.length > 20) {
              List<String> questionKeys = quizQuestions.keys.toList();
              questionKeys.shuffle();
              List<String> selectedQuestionKeys =
                  questionKeys.take(20).toList();

              quizQuestions = Map.fromEntries(quizQuestions.entries
                  .where((entry) => selectedQuestionKeys.contains(entry.key)));
            }
            quizAnswers = List<String>.from(
                quizQuestions.values.map((question) => question['ans']));
          });
          getTimer();
        } else {
          setState(() {
            isUnderDevelopment = true;
          });
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void getTimer() {
    countDownTimer = quizQuestions.length * 30;
    quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        countDownTimer--;
      });
      if (countDownTimer <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    quizTimer.cancel;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subName = widget.subName;
    getQuestions();
  }

  void nextQuestion() {
    if (index < quizQuestions.length - 1) {
      setState(() {
        isLastQuestion = false;
        index += 1;
      });
    }
    if (index + 1 == quizQuestions.length) {
      setState(() {
        isLastQuestion = true;
      });
    }
  }

  void quizSubmission() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return QuizScoreCard(
            subName: subName,
            totalQuestions: quizQuestions.length,
            selectedQuestions: selectedOptions,
            correctAnswers: quizAnswers,
            quizQuestions: quizQuestions,
          );
        },
      ),
    );
  }

  void optionSelected(String optionNo) {
    setState(() {
      selectedOptions[index] = optionNo;
    });
  }

  void prevQuestion() {
    if (index > 0) {
      setState(() {
        isLastQuestion = false;
        index -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const CircularLoadingScreen()
        : Scaffold(
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
                const SizedBox(
                  height: 30,
                ),
                SubjectHeadings(
                  primaryText: "Quiz",
                  subjectName: subName,
                ),
                const SizedBox(
                  height: 10,
                ),
                (isUnderDevelopment)
                    ? const Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          UnderDevelopment(),
                        ],
                      )
                    : (countDownTimer > 0)
                        ? Expanded(
                            child: Column(
                              children: [
                                QuizInfoBar(
                                  value: quizQuestions.length,
                                  desc: "Total Questions",
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                QuestionNumberTimerDisplayer(
                                  qNo: index + 1,
                                  countDownTimer: countDownTimer,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${quizQuestions.values.elementAt(index)['qName']}",
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.marianBlue,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          buildOptionWidget(
                                            optionNo: 'A',
                                            choiceDesc: quizQuestions.values
                                                .elementAt(index)['choice']
                                                .values
                                                .elementAt(0)
                                                .toString(),
                                          ),
                                          buildOptionWidget(
                                            optionNo: 'B',
                                            choiceDesc: quizQuestions.values
                                                .elementAt(index)['choice']
                                                .values
                                                .elementAt(1)
                                                .toString(),
                                          ),
                                          buildOptionWidget(
                                            optionNo: 'C',
                                            choiceDesc: quizQuestions.values
                                                .elementAt(index)['choice']
                                                .values
                                                .elementAt(2)
                                                .toString(),
                                          ),
                                          buildOptionWidget(
                                            optionNo: 'D',
                                            choiceDesc: quizQuestions.values
                                                .elementAt(index)['choice']
                                                .values
                                                .elementAt(3)
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : QuizTimeout(
                            countDownTimer: countDownTimer,
                            totalQuestions: quizQuestions.length,
                            quizSubmission: quizSubmission,
                          ),
              ],
            ),
            bottomNavigationBar: (countDownTimer > 0)
                ? BottomAppBar(
                    elevation: 0,
                    child: (isUnderDevelopment)
                        ? const SizedBox(
                            height: 0,
                          )
                        : PrevNextBtn(
                            totalQuestions: quizQuestions.length - 1,
                            index: index,
                            nextQuestion: nextQuestion,
                            prevQuestion: prevQuestion,
                            isLastQuestion: isLastQuestion,
                            quizSubmission: quizSubmission,
                          ),
                  )
                : null,
          );
  }

  Widget buildOptionWidget(
      {required String optionNo, required String choiceDesc}) {
    return GestureDetector(
      onTap: () => optionSelected(optionNo),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.07,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: (selectedOptions[index] == optionNo)
              ? AppColor.marianBlue.withOpacity(0.1)
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.fromBorderSide(
            BorderSide(
              width: (selectedOptions[index] == optionNo) ? 2 : 1,
              color: (selectedOptions[index] == optionNo)
                  ? AppColor.marianBlue
                  : AppColor.grey,
            ),
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                optionNo,
                style: const TextStyle(
                  color: AppColor.marianBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  choiceDesc,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: AppColor.marianBlue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
