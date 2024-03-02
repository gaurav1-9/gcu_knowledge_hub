import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(
            LucideIcons.rocket,
            color: AppColor.marianBlue,
            size: 50,
          ),
          Text(
            "Under Development\nWill be available soon",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.marianBlue,
            ),
          ),
        ],
      ),
    );
  }
}
