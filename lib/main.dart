import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './widgets/homescreen.dart';
import './widgets/login_screen.dart';
import './widgets/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const Homescreen(),
      },
      home: const Homescreen(),
    );
  }
}
