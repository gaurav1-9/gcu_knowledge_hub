import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class QuizInfoBar extends StatelessWidget {
  final int totalQuestions;
  final int unanswered;
  final int answered;
  const QuizInfoBar(
      {super.key,
      required this.totalQuestions,
      required this.unanswered,
      required this.answered});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
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
                      totalQuestions.toString(),
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
                  child: const Center(
                    child: Text(
                      "Total Questions",
                      style: TextStyle(
                        color: AppColor.marianBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                      answered.toString(),
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
                  child: const Center(
                    child: Text(
                      "Answered",
                      style: TextStyle(
                        color: AppColor.marianBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                      unanswered.toString(),
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
                  child: const Center(
                    child: Text(
                      "Unanswered",
                      style: TextStyle(
                        color: AppColor.marianBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}