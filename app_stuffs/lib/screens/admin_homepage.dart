import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/admin_home_menu.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/circular_loading_screen.dart';
import '../widgets/headings.dart';
import '../properties/global_colors.dart';
import '../widgets/gcu.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  late SharedPreferences pref;
  bool isRetrieving = true;

  void initPreferences() async {
    try {
      pref = await SharedPreferences.getInstance();
    } finally {
      setState(() {
        isRetrieving = false;
      });
    }
  }

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isRetrieving) {
      return const CircularLoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          titleSpacing: 20,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const GCUTextLogo(
                size: 60,
                fontSize: 16,
                alignment: MainAxisAlignment.start,
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        pref.setBool('isAdmin', false);
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      LucideIcons.logOut,
                      color: AppColor.marianBlue,
                      size: 25,
                    ),
                  ),
                  const Text(
                    "LOGOUT",
                    style: TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 8,
                      height: 0.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: AppColor.jonquil,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Headings(
                  primaryText: "Admin",
                  secondaryTextFirst: 'P',
                  secondaryText: "anel",
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/admin_dept_details');
                      },
                      child: const AdminHomeMenu(
                        primaryText: "Department Details",
                        secondaryText:
                            "Add new departments or edit the existing departments",
                        reverse: false,
                        icon: LucideIcons.school,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/admin_subject_details');
                      },
                      child: const AdminHomeMenu(
                        primaryText: "Subject Details",
                        secondaryText:
                            "Add new subjects, edit or delete the existing subjects",
                        reverse: true,
                        icon: LucideIcons.bookMarked,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/admin_quiz_details');
                      },
                      child: const AdminHomeMenu(
                        primaryText: "Question Details",
                        secondaryText:
                            "Add new quiz questions, edit or delete the existing quiz questions",
                        reverse: false,
                        icon: LucideIcons.fileText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
