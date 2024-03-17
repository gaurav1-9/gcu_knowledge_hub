import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/textfields/txt_fields.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/auth_text.dart';
import '../widgets/buttons/auth_login_btns.dart';
import '../widgets/gcu.dart';

enum RegigistrationStatus {
  success,
  serverError,
  sameUsernameError,
  neutral,
  emptyFields,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registrationFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedOption = 'student';
  bool isLoading = false;
  RegigistrationStatus isRegistrationSuccess = RegigistrationStatus.neutral;

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
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey there...',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.marianBlue,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _registrationFormKey,
                child: Column(
                  children: [
                    InputTextField(
                      textCapitalization: TextCapitalization.words,
                      hintText: "Name",
                      fieldType: LucideIcons.edit,
                      isPassword: false,
                      textController: _nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputTextField(
                      hintText: "Username",
                      fieldType: LucideIcons.user,
                      isPassword: false,
                      textController: _usernameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputTextField(
                      hintText: "Password",
                      fieldType: LucideIcons.lock,
                      isPassword: true,
                      textController: _passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.school_rounded,
                                      color: (_selectedOption == "student")
                                          ? AppColor.marianBlue
                                          : AppColor.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' STUDENT',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (_selectedOption == "student")
                                          ? AppColor.marianBlue
                                          : AppColor.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            value: 'student',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColor.marianBlue,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColor.marianBlue,
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.military_tech_outlined,
                                      color: (_selectedOption == "teacher")
                                          ? AppColor.marianBlue
                                          : AppColor.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'TEACHER',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (_selectedOption == "teacher")
                                          ? AppColor.marianBlue
                                          : AppColor.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            value: 'teacher',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    (isRegistrationSuccess == RegigistrationStatus.success)
                        ? const Column(
                            children: [
                              Text(
                                "Registered successfully",
                                style: TextStyle(
                                  color: AppColor.forestGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Please wait...redirecting",
                                    style: TextStyle(
                                      color: AppColor.forestGreen,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: AppColor.forestGreen,
                                      strokeWidth: 1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : (isRegistrationSuccess ==
                                RegigistrationStatus.emptyFields)
                            ? const Text(
                                "All input fields are required",
                                style: TextStyle(
                                  color: AppColor.tomato,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : (isRegistrationSuccess ==
                                    RegigistrationStatus.sameUsernameError)
                                ? const Text(
                                    "Username already taken",
                                    style: TextStyle(
                                      color: AppColor.tomato,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : (isRegistrationSuccess ==
                                        RegigistrationStatus.serverError)
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
                      btnType: "REGISTER",
                      iconType: LucideIcons.userPlus,
                      navigateTo: () => addUser(
                          _usernameController.text,
                          _nameController.text,
                          _passwordController.text,
                          _selectedOption),
                      isLoading: isLoading,
                      alignment: MainAxisAlignment.center,
                    ),
                    const LoginNewRegisterText(
                      text: "Already registered?",
                      textBtn: 'Click here to login',
                      isCurrentlyLogin: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addUser(String username, String name, String password,
      String selectedOption) async {
    const userAddURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/users.json";
    RegigistrationStatus registrationSuccessValue =
        RegigistrationStatus.neutral;

    if (username.isNotEmpty && name.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        final userNameResponse = await http.get(Uri.parse(userAddURL));

        if (userNameResponse.statusCode == 200) {
          final Map<String, dynamic> users = jsonDecode(userNameResponse.body);
          bool isDuplicateUsername =
              users.values.any((user) => user['username'] == username);

          if (isDuplicateUsername) {
            registrationSuccessValue = RegigistrationStatus.sameUsernameError;
          } else {
            await http
                .post(
              Uri.parse(userAddURL),
              body: json.encode({
                "name": name,
                "password": password,
                "username": username,
                "userType": selectedOption,
              }),
            )
                .then((value) {
              _nameController.text = '';
              _usernameController.text = '';
              _passwordController.text = '';
              registrationSuccessValue = RegigistrationStatus.success;
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pushReplacementNamed('/login');
              });
            });
          }
        }
        setState(() {
          isRegistrationSuccess = registrationSuccessValue;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isRegistrationSuccess = RegigistrationStatus.neutral;
          });
        });
      } catch (e) {
        setState(() {
          isRegistrationSuccess = RegigistrationStatus.serverError;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isRegistrationSuccess = RegigistrationStatus.neutral;
          });
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isRegistrationSuccess = RegigistrationStatus.emptyFields;
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isRegistrationSuccess = RegigistrationStatus.neutral;
        });
      });
    }
  }
}
