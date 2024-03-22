import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import 'textfields/txt_fields.dart';

class QuizAddQuestionChoice extends StatelessWidget {
  final TextEditingController question;
  final TextEditingController optA;
  final TextEditingController optB;
  final TextEditingController optC;
  final TextEditingController optD;
  final VoidCallback imageFunc;
  final File? questionImage;
  const QuizAddQuestionChoice({
    super.key,
    required this.question,
    required this.optA,
    required this.optB,
    required this.optC,
    required this.optD,
    required this.imageFunc,
    required this.questionImage,
  });

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
        Row(
          children: [
            IconButton(
              color: AppColor.marianBlue,
              icon: const Icon(LucideIcons.imagePlus),
              onPressed: imageFunc,
            ),
            GestureDetector(
              onTap: imageFunc,
              child: const Text(
                "Add illustration to your question",
                style: TextStyle(
                  color: AppColor.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        (questionImage != null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.file(questionImage!),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        InputTextField(
          hintText: "Option A",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optA,
        ),
        const SizedBox(
          height: 20,
        ),
        InputTextField(
          hintText: "Option B",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optB,
        ),
        const SizedBox(
          height: 20,
        ),
        InputTextField(
          hintText: "Option C",
          fieldType: LucideIcons.circleDot,
          isPassword: false,
          textCapitalization: TextCapitalization.sentences,
          textController: optC,
        ),
        const SizedBox(
          height: 20,
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
