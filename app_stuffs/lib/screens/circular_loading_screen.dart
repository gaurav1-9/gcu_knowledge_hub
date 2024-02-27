import 'package:flutter/material.dart';

import '../properties/global_colors.dart';

class CircularLoadingScreen extends StatelessWidget {
  const CircularLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: CircularProgressIndicator(
            color: AppColor.marianBlue,
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}
