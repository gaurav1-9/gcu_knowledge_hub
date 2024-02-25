import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/textfields/txt_fields.dart';
import '../widgets/buttons/auth_login_btns.dart';
import '../widgets/auth_text.dart';
import '../widgets/gcu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  int isLogginSuccess = -1;

  Future<void> checkCredentials(ctx, username, password) async {
    const loginURL =
        'https://gcu-knowledge-hub-default-rtdb.firebaseio.com/users.json';
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await http.get(Uri.parse(loginURL));
        if (response.statusCode == 200) {
          final Map<String, dynamic> users = jsonDecode(response.body);
          users.forEach((key, value) {
            if (value['username'] == username &&
                value['password'] == password) {
              print('Authentication successful');
              setState(() {
                isLogginSuccess = 1;
              });
            } else {
              setState(() {
                isLogginSuccess = 0;
              });
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  isLogginSuccess = -1;
                });
              });
              print('Authentication failed');
            }
          });
        }
      } catch (e) {
        // Handle network or server errors
        print('Error fetching user data: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLogginSuccess = -2;
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isLogginSuccess = -1;
        });
      });
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
      body: SingleChildScrollView(
        child: Container(
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
                height: 25,
              ),
              Center(
                child: Column(
                  children: [
                    (isLogginSuccess == 0)
                        ? const Text(
                            "Invalid Credentials",
                            style: TextStyle(
                              color: AppColor.tomato,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : (isLogginSuccess == -2)
                            ? const Text(
                                "All input fields are required",
                                style: TextStyle(
                                  color: AppColor.tomato,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(''),
                    AuthLogin(
                      btnType: "LOGIN",
                      iconType: LucideIcons.logIn,
                      navigateTo: () => checkCredentials(
                        context,
                        usernameController.text,
                        passwordController.text,
                      ),
                      isLoading: isLoading,
                      alignment: MainAxisAlignment.center,
                    ),
                    const LoginNewRegisterText(
                      text: "New user?",
                      textBtn: 'Click here',
                      isCurrentlyLogin: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
