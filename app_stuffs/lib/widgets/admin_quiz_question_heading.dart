import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class AdminQuizHeading extends StatelessWidget {
  final String totalQuestions;
  final String subName;
  const AdminQuizHeading({
    super.key,
    required this.totalQuestions,
    required this.subName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quizes of',
          style: TextStyle(
            color: AppColor.marianBlue,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subName,
          style: const TextStyle(
            color: AppColor.marianBlue,
            fontWeight: FontWeight.bold,
            fontSize: 23,
            height: 1,
          ),
        ),
        Text(
          "$totalQuestions total questions",
          style: const TextStyle(
            color: AppColor.marianBlue,
            // height: 0.5,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
