import 'package:flutter/material.dart';

import '../screens/quiz_score_card.dart';
import '../widgets/prev_next_btns.dart';
import '../widgets/question_no_display.dart';
import '../widgets/quiz_info.dart';
import '../widgets/under_development.dart';
import '../widgets/subjects_heading.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizesScreen extends StatefulWidget {
  final bool isUnderDevelopment;
  final String subName;
  final Map<String, dynamic> quizQuestions;
  const QuizesScreen({
    Key? key,
    required this.subName,
    required this.quizQuestions,
    required this.isUnderDevelopment,
  }) : super(key: key);

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  late bool isUnderDevelopment;
  late String subName;
  late Map<String, dynamic> quizQuestions;
  List<String> selectedOptions = []; // Track selected options for each question
  List<String> quizAnswers = [];
  int index = 0;

  bool isLastQuestion = false;

  @override
  void initState() {
    super.initState();
    subName = widget.subName;
    quizQuestions = widget.quizQuestions;
    isUnderDevelopment = widget.isUnderDevelopment;
    selectedOptions = List.filled(widget.quizQuestions.length, '');

    for (var i = 0; i < quizQuestions.length; i++) {
      quizAnswers.add(quizQuestions.values.elementAt(i)['ans']);
    }
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
            totalQuestions: quizQuestions.length,
            selectedQuestions: selectedOptions,
            correctAnswers: quizAnswers,
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
              : Expanded(
                  child: Column(
                    children: [
                      QuizInfoBar(
                        totalQuestions: quizQuestions.length,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      QuestionNumberDisplayer(qNo: index + 1),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
      ),
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
