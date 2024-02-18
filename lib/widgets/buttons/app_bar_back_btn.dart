import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../properties/global_colors.dart';

class AppBarBackBtn extends StatelessWidget {
  const AppBarBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        LucideIcons.arrowBigLeft,
        size: 30,
      ),
      color: AppColor.marianBlue,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
