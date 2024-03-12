import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/admin_dept_details_names.dart';
import '../screens/circular_loading_screen.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AdminDeptDetails extends StatefulWidget {
  const AdminDeptDetails({super.key});

  @override
  State<AdminDeptDetails> createState() => _AdminDeptDetailsState();
}

class _AdminDeptDetailsState extends State<AdminDeptDetails> {
  bool isLoading = true;
  Map<String, dynamic> branchNames = {};

  void getAllBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/branches.json";
    final response = await http
        .get(Uri.parse(branchURL))
        .timeout(const Duration(seconds: 10));

    try {
      if (jsonDecode(response.body) != null) {
        branchNames = jsonDecode(response.body);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAllBranch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const CircularLoadingScreen()
        : Scaffold(
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: branchNames.entries.map((entry) {
                    if (entry.key == 'arts') {
                      return AdminDepartment(
                        firstHead: 'School of',
                        secondHead: "Humanities & Social Sciences",
                        deptNames: entry.value,
                      );
                    } else if (entry.key == 'engineering_tech') {
                      return AdminDepartment(
                        firstHead: 'School of',
                        secondHead: "Engineering & Technology",
                        deptNames: entry.value,
                      );
                    } else if (entry.key == 'mgmnt_comm') {
                      return AdminDepartment(
                        firstHead: 'School of',
                        secondHead: "Management & Commerce",
                        deptNames: entry.value,
                      );
                    } else if (entry.key == 'nat_sci') {
                      return AdminDepartment(
                        firstHead: 'School of',
                        secondHead: "Natural Sciences",
                        deptNames: entry.value,
                      );
                    } else {
                      return AdminDepartment(
                        firstHead: 'School of',
                        secondHead: "Pharmaceutical Sciences",
                        deptNames: entry.value,
                      );
                    }
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
