import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';

class PrevNextBtn extends StatefulWidget {
  final int totalQuestions;
  final int index;
  final VoidCallback nextQuestion;
  final VoidCallback prevQuestion;
  const PrevNextBtn({
    super.key,
    required this.totalQuestions,
    required this.index,
    required this.nextQuestion,
    required this.prevQuestion,
  });

  @override
  State<PrevNextBtn> createState() => _PrevNextBtnState();
}

class _PrevNextBtnState extends State<PrevNextBtn> {
  late int totalQuestion;
  late int index;
  late VoidCallback nextQuestion;
  late VoidCallback prevQuestion;
  @override
  void initState() {
    super.initState();
    totalQuestion = widget.totalQuestions;
    index = widget.index;
    nextQuestion = widget.nextQuestion;
    prevQuestion = widget.prevQuestion;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            foregroundColor: AppColor.marianBlue,
          ),
          onPressed: () {
            prevQuestion();
          },
          child: const Row(
            children: [
              Icon(
                LucideIcons.arrowLeftCircle,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Prev\nQuestion"),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            foregroundColor: AppColor.marianBlue,
          ),
          onPressed: () {
            nextQuestion();
          },
          child: const Row(
            children: [
              Text(
                "Next\nQuestion",
                textAlign: TextAlign.end,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                LucideIcons.arrowRightCircle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
