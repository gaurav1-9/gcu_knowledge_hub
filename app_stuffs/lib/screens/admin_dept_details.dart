import 'package:flutter/material.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AdminDeptDetails extends StatefulWidget {
  const AdminDeptDetails({super.key});

  @override
  State<AdminDeptDetails> createState() => _AdminDeptDetailsState();
}

class _AdminDeptDetailsState extends State<AdminDeptDetails> {
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
      body: Text("Department Details"),
    );
  }
}
