import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class QuestionNumberDisplayer extends StatelessWidget {
  final int qNo;
  const QuestionNumberDisplayer({super.key, required this.qNo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
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
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
