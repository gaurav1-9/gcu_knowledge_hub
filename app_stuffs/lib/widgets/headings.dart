import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class Headings extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final String secondaryTextFirst;
  const Headings({
    super.key,
    required this.primaryText,
    this.secondaryText = '',
    this.secondaryTextFirst = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          primaryText,
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: AppColor.marianBlue,
            height: 1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              secondaryTextFirst,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
                height: 0.7,
                color: AppColor.marianBlue,
              ),
            ),
            Text(
              secondaryText,
              style: const TextStyle(
                letterSpacing: 2,
                height: 0.7,
                fontSize: 30,
                fontWeight: FontWeight.w100,
                color: AppColor.marianBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
