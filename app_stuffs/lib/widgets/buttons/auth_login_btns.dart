import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../properties/global_colors.dart';

class AuthLogin extends StatelessWidget {
  final String btnType;
  final IconData iconType;
  final VoidCallback navigateTo;
  final MainAxisAlignment alignment;
  final bool isLoading;

  const AuthLogin({
    super.key,
    required this.btnType,
    required this.iconType,
    required this.navigateTo,
    required this.alignment,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.jonquil,
          foregroundColor: AppColor.marianBlue,
        ),
        onPressed: navigateTo,
        child: (isLoading)
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColor.marianBlue,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: alignment,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(iconType),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppColor.marianBlue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    btnType,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
