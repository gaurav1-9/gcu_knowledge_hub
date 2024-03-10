import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/user_dashboard.dart';
import './screens/add_quiz_dept.dart';
import './screens/homescreen.dart';
import './screens/login_screen.dart';
import './screens/school_of_studies_screen.dart';
import './screens/register_screen.dart';
import 'screens/admin_homepage.dart';

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
  bool? isAdmin = false;
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
        '/addQuizDept': (context) => const AddQuizDept(),
        '/adminHome': (context) => const AdminHomepage(),
      },
      home: Builder(
        builder: (context) {
          if (isLoggedIn == true) {
            return const UserDashboard();
          } else if (isAdmin == true) {
            return const AdminHomepage();
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
      isAdmin = pref.getBool('isAdmin');
    });
  }
}
