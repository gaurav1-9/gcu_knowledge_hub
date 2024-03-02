import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AddQuiz extends StatelessWidget {
  const AddQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
      body: const Column(
        children: [
          SizedBox(
            height: 80,
          ),
          UnderDevelopment(),
        ],
      ),
    );
  }
}
