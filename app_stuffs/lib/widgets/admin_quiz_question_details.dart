import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class AdminQuestionInfo extends StatelessWidget {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  const AdminQuestionInfo({
    super.key,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          question,
          style: const TextStyle(
            color: AppColor.marianBlue,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "A.",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    optionA,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "B.",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    optionB,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "C.",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    optionC,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "D.",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    optionD,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Correct Option:",
                  style: TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    correctOption,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
