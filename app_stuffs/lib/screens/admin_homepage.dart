import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/gcu.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 20,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GCUTextLogo(
              size: 60,
              fontSize: 16,
              alignment: MainAxisAlignment.start,
            ),
            Icon(
              LucideIcons.logOut,
              color: AppColor.marianBlue,
            ),
          ],
        ),
        backgroundColor: AppColor.jonquil,
      ),
    );
  }
}
