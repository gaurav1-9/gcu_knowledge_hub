import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../properties/global_colors.dart';

class GCUTextLogo extends StatelessWidget {
  final double size;
  final double fontSize;
  final MainAxisAlignment alignment;
  const GCUTextLogo({
    super.key,
    required this.size,
    required this.fontSize,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Image.asset(
          'assets/img/GCU_Logo.png',
          height: size,
          width: size,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Text(
              'GIRIJANANDA',
              textAlign: TextAlign.left,
              style: GoogleFonts.cormorantGaramond(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize,
                  color: AppColor.marianBlue,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'C',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.cormorantGaramond(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: fontSize,
                      color: AppColor.marianBlue,
                    ),
                  ),
                ),
                Text(
                  'HOWDHURY',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.cormorantGaramond(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: fontSize,
                      color: AppColor.marianBlue,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'U',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: fontSize,
                      color: AppColor.marianBlue,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1.1,
                ),
                Text(
                  'NIVERSITY',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: fontSize,
                      color: AppColor.marianBlue,
                      letterSpacing: 2.2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
