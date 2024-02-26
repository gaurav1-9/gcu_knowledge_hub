import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../properties/global_colors.dart';
import 'circular_loading_screen.dart';
import '../widgets/gcu.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late SharedPreferences pref;
  bool isRetrieving = true;
  Map<String, dynamic>? userData;

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
          title: const GCUTextLogo(
            size: 60,
            fontSize: 16,
            alignment: MainAxisAlignment.start,
          ),
          backgroundColor: AppColor.jonquil,
        ),
        body: Column(
          children: [
            Text(
              'Welcome ${userData?['name']}',
            ),
            Text(
              'User Type: ${userData?['userType']}',
            ),
            Text(
              'USERNAME: ${userData?['username']}',
            ),
          ],
        ),
      );
    }
  }

  void initPreferences() async {
    try {
      pref = await SharedPreferences.getInstance();
      print(pref.getString('userData'));
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
