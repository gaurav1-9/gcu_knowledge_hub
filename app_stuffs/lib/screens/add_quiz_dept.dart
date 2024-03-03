import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/screens/add_quiz_subjects.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/headings.dart';
import '../widgets/under_development.dart';
import './circular_loading_screen.dart';

class AddQuizDept extends StatefulWidget {
  const AddQuizDept({super.key});

  @override
  State<AddQuizDept> createState() => _AddQuizDeptState();
}

class _AddQuizDeptState extends State<AddQuizDept> {
  bool isLoading = true;
  late Map routeArgs;
  Map<String, dynamic> branchNames = {};

  void getAllBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/branches.json";
    final response = await http
        .get(Uri.parse(branchURL))
        .timeout(const Duration(seconds: 10));

    try {
      if (jsonDecode(response.body) != null) {
        int i = 0;
        Map<String, dynamic> allBranchData = jsonDecode(response.body);

        for (var entry in allBranchData.values) {
          for (var innerEntry in entry.values) {
            branchNames["$i"] = innerEntry;
            i++;
          }
        }
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
    if (isLoading) {
      return const CircularLoadingScreen();
    } else {
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
              const Headings(
                primaryText: "Add Quiz",
                secondaryTextFirst: "Q",
                secondaryText: "uestion",
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Select Department",
                style: TextStyle(
                  color: AppColor.marianBlue,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              (branchNames.isEmpty)
                  ? const UnderDevelopment()
                  : Column(
                      children: branchNames.entries.map((entry) {
                        return Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                backgroundColor: AppColor.jonquil,
                                foregroundColor: AppColor.marianBlue,
                              ),
                              onPressed: () {
                                navigateToAddQuizSubjects(entry.value);
                              },
                              child: Text(
                                entry.value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }).toList(),
                    ),
            ],
          ),
        )),
      );
    }
  }

  void navigateToAddQuizSubjects(String branchName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AddQuizSubjects(deptname: branchName);
        },
      ),
    );
  }
}
