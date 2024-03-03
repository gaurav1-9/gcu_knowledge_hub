import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/headings.dart';
import '../widgets/under_development.dart';
import '../screens/circular_loading_screen.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import './add_quiz_screen.dart';

class AddQuizSubjects extends StatefulWidget {
  final String deptname;
  const AddQuizSubjects({super.key, required this.deptname});

  @override
  State<AddQuizSubjects> createState() => _AddQuizSubjectsState();
}

class _AddQuizSubjectsState extends State<AddQuizSubjects> {
  bool isLoading = true;
  Map<String, dynamic> questionSub = {};
  Map<String, dynamic> subValues = {};
  Map<String, dynamic> subQuestions = {};
  late String courseID;
  late String subID;
  late String subName;

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
        if (entry.value['branch'] == widget.deptname) {
          courseID = entry.key;
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
                const Headings(
                  primaryText: "Add Quiz",
                  secondaryTextFirst: "Q",
                  secondaryText: "uestion",
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Subjects of ${widget.deptname} Department",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.marianBlue,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                                  subID = entry.key;
                                  subName = entry.value['subName'];
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return AddQuiz(
                                      courseID: courseID,
                                      subID: subID,
                                      subName: subName,
                                    );
                                  }));
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
