import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  late SharedPreferences pref;

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  Map getUserData({String? name, String? username, String? userType}) {
    Map userData = {
      'name': name,
      'username': username,
      'userType': userType,
    };
    return userData;
  }

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
          int loginvalue = 0;
          for (var entry in users.entries) {
            var value = entry.value;

            if (value['username'] == username &&
                value['password'] == password) {
              pref.setString(
                'userData',
                jsonEncode(
                  getUserData(
                    name: value['name'],
                    userType: value['userType'],
                    username: value['username'],
                  ),
                ),
              );
              pref.setBool('isLogin', true);
              loginvalue = 1;
              navigateToUserDashboard(ctx);
              break;
            } else {
              loginvalue = 0;
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  isLogginSuccess = -1;
                });
              });
            }
          }
          setState(() {
            isLogginSuccess = loginvalue;
          });
        }
      } catch (e) {
        setState(() {
          isLogginSuccess = -3;
        });
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            isLogginSuccess = -1;
          });
        });
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

  void initPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  void navigateToUserDashboard(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/userDashboard',
      (route) => false,
    );
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            : (isLogginSuccess == -3)
                                ? const Column(
                                    children: [
                                      Text(
                                        "Oops...couldn't reach the server",
                                        style: TextStyle(
                                          color: AppColor.tomato,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Check your network connectivity",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.tomato,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
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
