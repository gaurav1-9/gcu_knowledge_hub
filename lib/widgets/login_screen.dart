import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/buttons/auth_login_btns.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/textfields/txt_fields.dart';
import './gcu.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void checkCredentials(ctx, username, password) {
    if (username != '' && password != '') {
      print(username);
      print(password);
      usernameController.text = '';
      passwordController.text = '';
      FocusScope.of(ctx).unfocus();
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.marianBlue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InputTextField(
              hintText: 'Username',
              isPassword: false,
              fieldType: LucideIcons.user,
              textController: usernameController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Password',
              isPassword: true,
              fieldType: LucideIcons.lock,
              textController: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                children: [
                  AuthLogin(
                    btnType: "LOGIN",
                    iconType: LucideIcons.logIn,
                    navigateTo: () => checkCredentials(
                      context,
                      usernameController.text,
                      passwordController.text,
                    ),
                    alignment: MainAxisAlignment.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New user?',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Click here",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.marianBlue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
