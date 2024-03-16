import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import './buttons/auth_login_btns.dart';
import './quiz_info.dart';

class QuizTimeout extends StatelessWidget {
  final int totalQuestions;
  final int countDownTimer;
  final VoidCallback quizSubmission;
  const QuizTimeout({
    super.key,
    required this.totalQuestions,
    required this.countDownTimer,
    required this.quizSubmission,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuizInfoBar(
          value: totalQuestions,
          desc: "Total Questions",
        ),
        const SizedBox(
          height: 40,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.timerOff,
              color: AppColor.marianBlue,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Times up!!",
              style: TextStyle(
                color: AppColor.marianBlue,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            "Click on the submit quiz button to see your score card",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.marianBlue,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
          child: AuthLogin(
            btnType: "Submit Quiz",
            alignment: MainAxisAlignment.center,
            iconType: LucideIcons.listChecks,
            navigateTo: quizSubmission,
            width: MediaQuery.of(context).size.width,
          ),
        )
      ],
    );
  }
}
