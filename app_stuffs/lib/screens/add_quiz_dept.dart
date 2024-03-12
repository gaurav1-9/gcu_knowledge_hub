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
  Map<String, dynamic> branchNames = {};

  void getAllBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools.json";
    final response = await http.get(Uri.parse(branchURL));
    try {
      if (jsonDecode(response.body) != null) {
        int k = 0;
        Map<String, dynamic> allBranchData = jsonDecode(response.body);
        for (int i = 0; i < allBranchData.length; i++) {
          for (var j = 0;
              j < allBranchData.values.elementAt(i)['branchNames'].length;
              j++) {
            branchNames[
                    "${allBranchData.keys.elementAt(i)}_${allBranchData.values.elementAt(i)['branchNames'].keys.elementAt(j)}"] =
                allBranchData.values
                    .elementAt(i)['branchNames']
                    .values
                    .elementAt(j)['dept'];
            k++;
          }
          branchNames["$k"] = 'gap';
          k++;
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
                        return (entry.value == 'gap')
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                        MediaQuery.of(context).size.width * .7,
                                        MediaQuery.of(context).size.width * .18,
                                      ),
                                      backgroundColor: AppColor.jonquil,
                                      foregroundColor: AppColor.marianBlue,
                                    ),
                                    onPressed: () {
                                      navigateToAddQuizSubjects(
                                        entry.key,
                                        entry.value,
                                      );
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

  void navigateToAddQuizSubjects(String branchMetaData, String branchName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AddQuizSubjects(
            deptID: branchMetaData.split('_')[1],
            schID: branchMetaData.split('_')[0],
            deptName: branchName,
          );
        },
      ),
    );
  }
}
