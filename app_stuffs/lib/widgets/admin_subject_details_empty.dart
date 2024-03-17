import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';

class AdminNoSubjects extends StatelessWidget {
  final VoidCallback navigateTo;
  const AdminNoSubjects({
    super.key,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "No quiz questions present till now",
            style: TextStyle(
              color: AppColor.marianBlue,
              fontSize: 17,
            ),
          ),
          const Text(
            "Click on the + button to add more quizes",
            style: TextStyle(
              color: AppColor.marianBlue,
              fontSize: 12,
            ),
          ),
          Container(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width * 0.15,
            ),
            child: IconButton(
              style:
                  IconButton.styleFrom(backgroundColor: AppColor.jonquilLight),
              onPressed: navigateTo,
              icon: const Icon(
                LucideIcons.plus,
                color: AppColor.marianBlue,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
