import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class AdminHomeMenu extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final bool reverse;
  final IconData icon;
  const AdminHomeMenu({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.reverse,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (reverse) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: AppColor.jonquil,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    primaryText,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.marianBlue,
                    ),
                  ),
                  Text(
                    secondaryText,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      height: 1,
                      color: AppColor.raisinBlack,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: AppColor.marianBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Icon(
              icon,
              size: 40,
              color: AppColor.jonquil,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: AppColor.marianBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Icon(
              icon,
              size: 40,
              color: AppColor.jonquil,
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: AppColor.jonquil,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    primaryText,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColor.marianBlue,
                    ),
                  ),
                  Text(
                    secondaryText,
                    style: const TextStyle(
                      height: 1,
                      color: AppColor.raisinBlack,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
