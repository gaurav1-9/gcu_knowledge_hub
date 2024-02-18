import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class LoginNewRegisterText extends StatelessWidget {
  final String text;
  final String textBtn;

  const LoginNewRegisterText({
    super.key,
    required this.text,
    required this.textBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppColor.grey,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            textBtn,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.marianBlue,
            ),
          ),
        )
      ],
    );
  }
}
