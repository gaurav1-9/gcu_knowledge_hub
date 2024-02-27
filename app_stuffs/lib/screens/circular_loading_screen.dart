import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/gcu.dart';

class CircularLoadingScreen extends StatelessWidget {
  const CircularLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const GCUTextLogo(
          size: 60,
          fontSize: 16,
          alignment: MainAxisAlignment.start,
        ),
        backgroundColor: AppColor.jonquil,
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: AppColor.marianBlue,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
