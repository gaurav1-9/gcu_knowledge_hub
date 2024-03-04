import 'package:flutter/material.dart';
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
                )
        ],
      ),
    );
  }
}
