import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/screens/subjects_screen.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/headings.dart';
import 'circular_loading_screen.dart';

class BranchSchool extends StatefulWidget {
  final String schID;
  const BranchSchool({super.key, required this.schID});

  @override
  State<BranchSchool> createState() => _BranchSchoolState();
}

class _BranchSchoolState extends State<BranchSchool> {
  bool isLoading = true;
  late String schID;
  Map<String, dynamic> branchNames = {};

  void getBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-1a7b9-default-rtdb.firebaseio.com/schools/${widget.schID}/branchNames.json";
    final response = await http.get(Uri.parse(branchURL));
    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> branchData = jsonDecode(response.body);
        for (var i = 0; i < branchData.length; i++) {
          branchNames.addAll({
            branchData.keys.elementAt(i): branchData.values.elementAt(i)['dept']
          });
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
    getBranch();
    super.initState();
    schID = widget.schID;
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
                primaryText: "Department",
                secondaryTextFirst: "S",
                secondaryText: "election",
              ),
              const SizedBox(
                height: 40,
              ),
              (branchNames.isEmpty)
                  ? const UnderDevelopment()
                  : Column(
                      children: branchNames.entries.map((entry) {
                        return Column(
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
                                navigateToSubjects(
                                    schID, entry.key, entry.value);
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

  void navigateToSubjects(String schID, String branchID, String branchName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Subjects(
            branchID: branchID,
            schID: schID,
            branchName: branchName,
          );
        },
      ),
    );
  }
}
