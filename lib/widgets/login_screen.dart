import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/textfields/txt_fields.dart';
import './gcu.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 1,
        leading: const AppBarBackBtn(),
        title: const GCUTextLogo(
          size: 60,
          fontSize: 16,
          alignment: MainAxisAlignment.start,
        ),
        backgroundColor: AppColor.jonquil,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 80,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InputTextField(
              hintText: 'Username',
              isPaaword: false,
              fieldType: LucideIcons.user,
            ),
            SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Password',
              isPaaword: true,
              fieldType: LucideIcons.lock,
            )
          ],
        ),
      ),
    );
  }
}
