import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/user_dashboard.dart';
import './screens/homescreen.dart';
import './screens/login_screen.dart';
import './screens/school_of_studies_screen.dart';
import './screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn = false;
  late SharedPreferences pref;

  @override
  void initState() {
    getInitPrefernces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const Homescreen(),
        '/userDashboard': (context) => const UserDashboard(),
        '/schools': (context) => const SchoolOfStudies(),
      },
      home: Builder(
        builder: (context) {
          if (isLoggedIn == true) {
            return const UserDashboard();
          } else {
            return const Homescreen();
          }
        },
      ),
    );
  }

  void getInitPrefernces() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = pref.getBool('isLogin');
    });
  }
}
