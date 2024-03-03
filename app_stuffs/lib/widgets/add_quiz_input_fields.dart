import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'textfields/txt_fields.dart';

class QuizAddQuestionChoice extends StatelessWidget {
  final TextEditingController question;
  final TextEditingController optA;
  final TextEditingController optB;
  final TextEditingController optC;
  final TextEditingController optD;
  const QuizAddQuestionChoice(
      {super.key,
      required this.question,
      required this.optA,
      required this.optB,
      required this.optC,
      required this.optD});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextField(
          hintText: "Question",
          fieldType: LucideIcons.fileQuestion,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: question,
        ),
        const SizedBox(
          height: 15,
        ),
        InputTextField(
          hintText: "Option A",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optA,
        ),
        const SizedBox(
          height: 15,
        ),
        InputTextField(
          hintText: "Option B",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optB,
        ),
        const SizedBox(
          height: 15,
        ),
        InputTextField(
          hintText: "Option C",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optC,
        ),
        const SizedBox(
          height: 15,
        ),
        InputTextField(
          hintText: "Option D",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optD,
        ),
      ],
    );
  }
}
