import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/headings.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class SchoolOfStudies extends StatefulWidget {
  const SchoolOfStudies({super.key});

  @override
  State<SchoolOfStudies> createState() => _SchoolOfStudiesState();
}

class _SchoolOfStudiesState extends State<SchoolOfStudies> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Headings(
                primaryText: "School",
                secondaryTextFirst: "O",
                secondaryText: "f Studies",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
