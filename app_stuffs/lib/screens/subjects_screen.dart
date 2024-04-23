import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/screens/quizes_screen.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';
import 'package:http/http.dart' as http;

import '../widgets/subjects_heading.dart';
import '../screens/circular_loading_screen.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class Subjects extends StatefulWidget {
  final String branchID;
  final String branchName;
  final String schID;
  const Subjects({
    super.key,
    required this.branchID,
    required this.schID,
    required this.branchName,
  });

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  bool isLoading = true;
  bool isUnderDevelopment = false;
  Map<String, dynamic> questionSub = {};
  Map<String, dynamic> subValues = {};
  Map<String, dynamic> subQuestions = {};

  void getSubjects() async {
    String subjectsURL =
        "https://gcu-knowledge-hub-1a7b9-default-rtdb.firebaseio.com/schools/${widget.schID}/branchNames/${widget.branchID}/subjects.json";
    final response = await http.get(Uri.parse(subjectsURL));
    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> subjectData = jsonDecode(response.body);
        for (var i = 0; i < subjectData.length; i++) {
          subValues.addAll({
            subjectData.keys.elementAt(i):
                subjectData.values.elementAt(i)['subName']
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
    getSubjects();
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
                SubjectHeadings(
                  primaryText: "Subjects",
                  subjectName: widget.branchName,
                ),
                const SizedBox(
                  height: 40,
                ),
                (subValues.isEmpty)
                    ? const UnderDevelopment()
                    : Column(
                        children: subValues.entries.map((entry) {
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
                                  navigateToQuestions(
                                    branchID: widget.branchID,
                                    schID: widget.schID,
                                    subID: entry.key,
                                    subName: entry.value,
                                  );
                                },
                                child: Text(
                                  entry.value.toString(),
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
          ),
        ),
      );
    }
  }

  void navigateToQuestions({
    required String schID,
    required String branchID,
    required String subID,
    required String subName,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return QuizesScreen(
            branchID: branchID,
            schID: schID,
            subID: subID,
            subName: subName,
          );
        },
      ),
    );
  }
}
