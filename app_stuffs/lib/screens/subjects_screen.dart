import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';
import 'package:http/http.dart' as http;

import '../widgets/subjects_heading.dart';
import '../screens/circular_loading_screen.dart';
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
  bool isLoading = true;
  Map<String, dynamic> questionSub = {};
  Map<String, dynamic> subValues = {};
  Map<String, dynamic> subQuestions = {};

  void getSubjects() async {
    String questionsURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/question.json";
    final response = await http
        .get(Uri.parse(questionsURL))
        .timeout(const Duration(seconds: 10));
    try {
      Map<String, dynamic> apiQuestionData = jsonDecode(response.body);
      questionSub.addAll(apiQuestionData);
      for (var entry in questionSub.entries) {
        if (entry.value['branch'] == widget.branchName) {
          subValues.clear();
          subValues.addAll(entry.value['subjects']);
          break;
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
                                  fixedSize: const Size(250, 60),
                                  backgroundColor: AppColor.jonquil,
                                  foregroundColor: AppColor.marianBlue,
                                ),
                                onPressed: () {
                                  subQuestions.clear();
                                  subQuestions.addAll(entry.value['questions']);
                                  print(
                                      "QUESTIONS IN ${entry.value['subName']}: ${subQuestions.length}");
                                },
                                child: Text(
                                  entry.value['subName'],
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
}
