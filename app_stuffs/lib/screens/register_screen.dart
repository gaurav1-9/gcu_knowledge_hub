import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcu_knowledge_hub/widgets/textfields/txt_fields.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/auth_text.dart';
import '../widgets/gcu.dart';

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
                      hintText: "Name",
                      fieldType: LucideIcons.edit,
                      isPassword: false,
                      textController: _nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextField(
                      hintText: "Username",
                      fieldType: LucideIcons.user,
                      isPassword: false,
                      textController: _usernameController,
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                  ],
                ),
              ),
              const LoginNewRegisterText(
                text: "Already registered?",
                textBtn: 'Click here to login',
                isCurrentlyLogin: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
