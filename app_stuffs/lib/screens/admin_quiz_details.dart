import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AdminQuizDetails extends StatefulWidget {
  const AdminQuizDetails({super.key});

  @override
  State<AdminQuizDetails> createState() => _AdminQuizDetailsState();
}

class _AdminQuizDetailsState extends State<AdminQuizDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 1,
        leading: const AppBarBackBtn(),
        title: const GCUTextLogo(
          size: 60,
          fontSize: 16,
          alignment: MainAxisAlignment.start,
        ),
        backgroundColor: AppColor.jonquil,
      ),
      body: Text("Quiz Details"),
    );
  }
}
