import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/admin_quiz_question_details.dart';
import '../widgets/admin_quiz_question_heading.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/buttons/auth_login_btns.dart';
import '../widgets/gcu.dart';
import './circular_loading_screen.dart';

enum ShowMsg {
  neutral,
  isEmpty,
  successfull,
  serverError,
}

class AdminQuizDetailsQuestions extends StatefulWidget {
  final String deptID;
  final String schID;
  final String subID;
  final String subName;
  const AdminQuizDetailsQuestions({
    super.key,
    required this.deptID,
    required this.schID,
    required this.subID,
    required this.subName,
  });

  @override
  State<AdminQuizDetailsQuestions> createState() =>
      _AdminQuizDetailsQuestionsState();
}

class _AdminQuizDetailsQuestionsState extends State<AdminQuizDetailsQuestions> {
  bool isLoading = true;
  late String deptID;
  late String schID;
  late String subID;
  late String subName;
  Map<String, dynamic> quizes = {};

  ShowMsg showMsg = ShowMsg.neutral;

  void getQuizDetails() async {
    String subQuizesURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$deptID/subjects/$subID/questions.json";
    final response = await http.get(Uri.parse(subQuizesURL));
    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> rawSubQuizes = jsonDecode(response.body);
        for (int i = 0; i < rawSubQuizes.length; i++) {
          quizes.addAll(
            ({
              rawSubQuizes.keys.elementAt(i): rawSubQuizes.values.elementAt(i)
            }),
          );
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
    super.initState();
    deptID = widget.deptID;
    schID = widget.schID;
    subID = widget.subID;
    subName = widget.subName;
    getQuizDetails();
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
            body: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdminQuizHeading(
                    subName: subName,
                    totalQuestions: quizes.length.toString(),
                  ),
                  (quizes.isEmpty)
                      ? Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "No quiz questions present till now",
                                style: TextStyle(
                                  color: AppColor.marianBlue,
                                  fontSize: 17,
                                ),
                              ),
                              const Text(
                                "Click on the + button to add more quizes",
                                style: TextStyle(
                                  color: AppColor.marianBlue,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.15,
                                ),
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: AppColor.jonquilLight),
                                  onPressed: () {},
                                  icon: const Icon(
                                    LucideIcons.plus,
                                    color: AppColor.marianBlue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              AuthLogin(
                                alignment: MainAxisAlignment.center,
                                btnType: "Add quiz",
                                iconType: LucideIcons.plus,
                                navigateTo: () {},
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: quizes.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Question ${index + 1}",
                                              style: const TextStyle(
                                                color: AppColor.marianBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    print(
                                                        "Edit btn of: ${quizes.keys.elementAt(index)}");
                                                  },
                                                  icon: const Icon(
                                                    LucideIcons.edit,
                                                    color: AppColor.marianBlue,
                                                    size: 19,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _showAlertDialog(
                                                        questionID: quizes.keys
                                                            .elementAt(index),
                                                        context: context,
                                                        deptID: deptID,
                                                        subID: subID,
                                                        questionNo:
                                                            "${index + 1}");
                                                  },
                                                  icon: const Icon(
                                                    LucideIcons.trash2,
                                                    color: AppColor.marianBlue,
                                                    size: 19,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        AdminQuestionInfo(
                                          question: quizes.values
                                              .elementAt(index)['qName'],
                                          optionA: quizes.values
                                              .elementAt(index)['choice']['A'],
                                          optionB: quizes.values
                                              .elementAt(index)['choice']['B'],
                                          optionC: quizes.values
                                              .elementAt(index)['choice']['C'],
                                          optionD: quizes.values
                                              .elementAt(index)['choice']['D'],
                                          correctOption: quizes.values
                                              .elementAt(index)['ans'],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
  }

  void _showAlertDialog({
    required BuildContext context,
    required String deptID,
    required String subID,
    required String questionNo,
    required String questionID,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColor.marianBlue,
            ),
          ),
          content: Text(
            'You want to delete Question $questionNo from $subName',
            style: const TextStyle(
              color: AppColor.marianBlue,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: AppColor.marianBlue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteSub(
                  ctx: context,
                  subID: subID,
                  questionID: questionID,
                  subName: subName,
                );
              },
              child: const Text(
                'DELETE',
                style: TextStyle(
                  color: AppColor.tomato,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void deleteSub({
    required String subName,
    required String subID,
    required String questionID,
    required BuildContext ctx,
  }) async {
    String deleteURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$deptID/subjects/$subID/questions/$questionID.json";
    try {
      await http.delete(Uri.parse(deleteURL));
    } catch (e) {
      showMsg = ShowMsg.serverError;
    } finally {
      if (showMsg == ShowMsg.serverError) {
        Navigator.of(context).pop();
        showMsg = ShowMsg.neutral;
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AdminQuizDetailsQuestions(
            deptID: deptID,
            schID: schID,
            subID: subID,
            subName: subName,
          );
        }));
      }
    }
  }
}
