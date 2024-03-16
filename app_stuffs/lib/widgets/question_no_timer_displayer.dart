import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class QuestionNumberTimerDisplayer extends StatelessWidget {
  final int qNo;
  final int countDownTimer;
  const QuestionNumberTimerDisplayer({
    super.key,
    required this.qNo,
    required this.countDownTimer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (countDownTimer >= 10)
                            ? RichText(
                                text: TextSpan(
                                    text: countDownTimer.toString(),
                                    style: const TextStyle(
                                      color: AppColor.forestGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: " seconds left",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: AppColor.marianBlue,
                                        ),
                                      ),
                                    ]),
                              )
                            : RichText(
                                text: TextSpan(
                                    text: "0${countDownTimer.toString()}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColor.tomato,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: " seconds left",
                                        style: TextStyle(
                                          color: AppColor.marianBlue,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ]),
                              ),
                      ],
                    ))
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
