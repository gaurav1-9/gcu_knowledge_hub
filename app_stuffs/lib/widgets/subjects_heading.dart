import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class SubjectHeadings extends StatelessWidget {
  final String primaryText;
  final String subjectName;
  const SubjectHeadings({
    super.key,
    required this.primaryText,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              primaryText,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: AppColor.marianBlue,
                height: 1.3,
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: Text(
            subjectName,
            style: const TextStyle(
              letterSpacing: 1,
              height: 1,
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: AppColor.marianBlue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
