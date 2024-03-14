import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import 'circular_loading_screen.dart';

enum ShowMsg {
  neutral,
  isEmpty,
  successfull,
  serverError,
}

class AdminQuizDetailsSubject extends StatefulWidget {
  final String schID;
  final String branchID;
  final String schName;
  final String branchName;
  const AdminQuizDetailsSubject({
    super.key,
    required this.schID,
    required this.branchID,
    required this.schName,
    required this.branchName,
  });

  @override
  State<AdminQuizDetailsSubject> createState() =>
      _AdminQuizDetailsSubjectState();
}

class _AdminQuizDetailsSubjectState extends State<AdminQuizDetailsSubject> {
  bool isLoading = true;
  late String schID;
  late String branchID;
  late String schName;
  late String branchName;
  Map<String, dynamic> deptSubjects = {};
  TextEditingController subNameController = TextEditingController();

  ShowMsg showMsg = ShowMsg.neutral;

  void getDeptSubjects() async {
    String deptSubjectsURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$branchID/subjects.json";
    final response = await http.get(Uri.parse(deptSubjectsURL));
    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> rawDeptSubjects = jsonDecode(response.body);
        for (int i = 0; i < rawDeptSubjects.length; i++) {
          deptSubjects.addAll({
            rawDeptSubjects.keys.elementAt(i):
                rawDeptSubjects.values.elementAt(i)['subName']
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
    super.initState();
    schID = widget.schID;
    branchID = widget.branchID;
    branchName = widget.branchName;
    schName = widget.schName;
    getDeptSubjects();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Subjects of',
                        style: TextStyle(
                          color: AppColor.marianBlue,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        branchName,
                        style: const TextStyle(
                          color: AppColor.marianBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  (deptSubjects.isEmpty)
                      ? Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No subjects present till now",
                                style: TextStyle(
                                  color: AppColor.marianBlue,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "Go to \"Subject Detaials\" page to add\nmore subjects",
                                style: TextStyle(
                                  color: AppColor.marianBlue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text(""),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9 / 7,
                      ),
                      itemCount: deptSubjects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColor.jonquil,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print(deptSubjects.values.elementAt(index));
                              },
                              splashColor:
                                  AppColor.jonquilLight.withOpacity(0.3),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      deptSubjects.values.elementAt(index),
                                      style: const TextStyle(
                                        color: AppColor.marianBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
