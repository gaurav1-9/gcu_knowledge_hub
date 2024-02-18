import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import './gcu.dart';
import './login_screen.dart';
import './register_screen.dart';
import './buttons/auth_login_btns.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return LoginScreen();
        },
      ),
    );
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const RegisterScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: AppColor.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AuthLogin(
            btnType: 'LOGIN',
            iconType: LucideIcons.logIn,
            navigateTo: () => navigateToLogin(context),
            alignment: MainAxisAlignment.start,
          ),
          const SizedBox(
            height: 10,
          ),
          AuthLogin(
            btnType: 'REGISTER',
            iconType: LucideIcons.userPlus,
            navigateTo: () {
              navigateToRegister(context);
            },
            alignment: MainAxisAlignment.start,
          ),
        ],
      ),
    );
  }
}
