import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/prev_next_btns.dart';
import 'package:gcu_knowledge_hub/widgets/quiz_info.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';

import '../widgets/subjects_heading.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizesScreen extends StatefulWidget {
  final bool isUnderDevelopment;
  final String subName;
  final Map<String, dynamic> quizQuestions;
  const QuizesScreen(
      {super.key,
      required this.subName,
      required this.quizQuestions,
      required this.isUnderDevelopment});

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  int answered = 0;
  int index = 0;
  late bool isUnderDevelopment;
  late int unanswered;
  late String subName;
  late Map<String, dynamic> quizQuestions;

  @override
  void initState() {
    super.initState();
    unanswered = widget.quizQuestions.length;
    subName = widget.subName;
    quizQuestions = widget.quizQuestions;
    isUnderDevelopment = widget.isUnderDevelopment;
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
              ? const UnderDevelopment()
              : QuizInfoBar(
                  totalQuestions: quizQuestions.length,
                  unanswered: unanswered,
                  answered: answered,
                ),
          const SizedBox(
            height: 20,
          ),
          (isUnderDevelopment)
              ? const SizedBox(
                  height: 0,
                )
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Question ",
                                style: const TextStyle(
                                  color: AppColor.marianBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                children: [
                                  (index + 1 < 10)
                                      ? TextSpan(text: "0${index + 1}")
                                      : TextSpan(text: "${index + 1}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          "${quizQuestions.values.elementAt(index)['qName']}\n\n",
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.marianBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          PrevNextBtn(
            totalQuestions: quizQuestions.length - 1,
            index: index,
            nextQuestion: nextQuestion,
            prevQuestion: prevQuestion,
          ),
        ],
      ),
    );
  }

  void nextQuestion() {
    if (index < quizQuestions.length - 1) {
      setState(() {
        index += 1;
      });
    }
  }

  void prevQuestion() {
    if (index > 0) {
      setState(() {
        index -= 1;
      });
    }
  }
}
