import 'package:flutter/material.dart';

import '../../properties/global_colors.dart';

class TextButtonScoreCard extends StatelessWidget {
  final VoidCallback btnFunction;
  final IconData iconArrow;
  final String text;
  const TextButtonScoreCard({
    super.key,
    required this.btnFunction,
    required this.iconArrow,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: btnFunction,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconArrow,
              size: 17,
              color: AppColor.marianBlue,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                color: AppColor.marianBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
