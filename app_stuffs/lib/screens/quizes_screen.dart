import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class QuizesScreen extends StatefulWidget {
  final String subName;
  final Map<String, dynamic> quizQuestions;
  const QuizesScreen(
      {super.key, required this.subName, required this.quizQuestions});

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
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
      body: Text(
        "Subject Name: ${widget.subName}\nNo of quizez: ${widget.quizQuestions.length}",
      ),
    );
  }
}
