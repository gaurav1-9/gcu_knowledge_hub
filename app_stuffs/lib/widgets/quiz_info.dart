import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class QuizInfoBar extends StatelessWidget {
  final int value;
  final String desc;
  const QuizInfoBar({
    super.key,
    required this.value,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(
              left: 10,
              right: 5,
            ),
            decoration: const BoxDecoration(
              color: AppColor.marianBlue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  color: AppColor.jonquil,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            height: 40,
            padding: const EdgeInsets.only(
              left: 5,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: AppColor.jonquil,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Center(
              child: Text(
                desc,
                style: const TextStyle(
                  color: AppColor.marianBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
