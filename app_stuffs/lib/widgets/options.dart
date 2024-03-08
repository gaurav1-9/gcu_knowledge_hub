import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcu_knowledge_hub/properties/global_colors.dart';

class MCQOptions extends StatelessWidget {
  final String optionNo;
  final String choiceDesc;
  const MCQOptions(
      {super.key, required this.optionNo, required this.choiceDesc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          optionNo,
          style: const TextStyle(
            color: AppColor.marianBlue,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            choiceDesc,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: AppColor.marianBlue,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
