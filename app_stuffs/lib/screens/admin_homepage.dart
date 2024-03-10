import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/screens/circular_loading_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  size: 30,
                ),
              ),
            ],
          ),
          backgroundColor: AppColor.jonquil,
        ),
      );
    }
  }
}
