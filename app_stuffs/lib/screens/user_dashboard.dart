import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './circular_loading_screen.dart';
import '../properties/global_colors.dart';
import '../widgets/gcu.dart';
import '../widgets/buttons/auth_login_btns.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late SharedPreferences pref;
  bool isRetrieving = true;
  bool isLoading = false;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  void navigateToAddQuiz(BuildContext context) {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushNamed('/addQuizDept');
  }

  void navigateToSchools(BuildContext context) {
    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushNamed('/schools');
  }

  void navigateToHome(BuildContext context) {
    setState(() {
      pref.setBool('isLogin', false);
    });

    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isRetrieving) {
      return const CircularLoadingScreen();
    } else {
      return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AuthLogin(
                btnType: "LOGOUT",
                iconType: LucideIcons.logOut,
                navigateTo: () => navigateToHome(context),
                alignment: MainAxisAlignment.center,
                fontSize: 10,
                width: 0.4,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: (!isLoading)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, ${userData?['name'].toString().split(' ')[0]}...',
                      style: GoogleFonts.cormorantGaramond(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: AppColor.marianBlue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const GCUTextLogo(
                      size: 120,
                      fontSize: 20,
                      alignment: MainAxisAlignment.center,
                    ),
                    Text(
                      'KNOWLEDGE HUB',
                      style: GoogleFonts.cormorantGaramond(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: AppColor.marianBlue,
                        ),
                      ),
                    ),
                    Text(
                      '"Boost your knowledge & ace your exams"',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Your personalized portal to academic success!\nPractice quizzes curated by faculties & gain\nmastery accross various subjects...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: SizedBox(
                        width: (userData?['userType'] == 'student') ? 230 : 270,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.jonquil,
                            foregroundColor: AppColor.marianBlue,
                          ),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            if (userData?['userType'] == 'student') {
                              navigateToSchools(context);
                            } else {
                              navigateToAddQuiz(context);
                            }
                          },
                          child: (userData?['userType'] == 'student')
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'GET STARTED',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      LucideIcons.arrowRight,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ADD QUIZ QUESTION",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      LucideIcons.arrowRight,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                      color: AppColor.marianBlue,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
        ),
      );
    }
  }

  void initPreferences() async {
    try {
      pref = await SharedPreferences.getInstance();
      String? userDataString = pref.getString('userData');
      if (userDataString != null) {
        userData = jsonDecode(userDataString);
      }
    } finally {
      setState(() {
        isRetrieving = false;
      });
    }
  }
}
