import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/subjects_heading.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class Subjects extends StatefulWidget {
  final String branchName;
  const Subjects({super.key, required this.branchName});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SubjectHeadings(
                primaryText: "Subjects",
                subjectName: widget.branchName,
              )
            ],
          ),
        ),
      ),
    );
  }
}
