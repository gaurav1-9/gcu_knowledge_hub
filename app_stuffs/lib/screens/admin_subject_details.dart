import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AdminSubjectDetails extends StatefulWidget {
  const AdminSubjectDetails({super.key});

  @override
  State<AdminSubjectDetails> createState() => _AdminSubjectDetailsState();
}

class _AdminSubjectDetailsState extends State<AdminSubjectDetails> {
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
      body: Text("Subject Details"),
    );
  }
}
