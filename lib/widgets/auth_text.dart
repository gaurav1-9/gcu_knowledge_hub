import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../properties/global_colors.dart';

class LoginNewRegisterText extends StatelessWidget {
  final String text;
  final String textBtn;
  final bool isCurrentlyLogin;

  const LoginNewRegisterText({
    super.key,
    required this.text,
    required this.textBtn,
    required this.isCurrentlyLogin,
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
          onPressed: () {
            if (isCurrentlyLogin) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          },
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
