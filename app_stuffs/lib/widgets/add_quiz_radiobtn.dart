import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class QuizAddRadio extends StatelessWidget {
  final Function(String?) selctionFunction;
  final String value;
  final String correctOption;
  const QuizAddRadio(
      {super.key,
      required this.selctionFunction,
      required this.value,
      required this.correctOption});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: AppColor.marianBlue,
        value: value,
        groupValue: correctOption,
        onChanged: selctionFunction,
        title: Text(
          textAlign: TextAlign.start,
          "Option $value",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                (correctOption == value) ? AppColor.marianBlue : AppColor.grey,
          ),
        ),
      ),
    );
  }
}
