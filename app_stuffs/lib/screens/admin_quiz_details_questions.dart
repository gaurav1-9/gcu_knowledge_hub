import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
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
        print(quizes);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quizes of',
                        style: TextStyle(
                          color: AppColor.marianBlue,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        subName,
                        style: const TextStyle(
                          color: AppColor.marianBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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
                                                    print(
                                                        "Delete btn of: ${quizes.keys.elementAt(index)}");
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
                                        const Divider(),
                                        Text(
                                          quizes.values
                                              .elementAt(index)['qName'],
                                          style: const TextStyle(
                                            color: AppColor.marianBlue,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "A.",
                                                  style: TextStyle(
                                                    color: AppColor.marianBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    quizes.values.elementAt(
                                                        index)['choice']['A'],
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.marianBlue,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "B.",
                                                  style: TextStyle(
                                                    color: AppColor.marianBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    quizes.values.elementAt(
                                                        index)['choice']['B'],
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.marianBlue,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "C.",
                                                  style: TextStyle(
                                                    color: AppColor.marianBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    quizes.values.elementAt(
                                                        index)['choice']['C'],
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.marianBlue,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "D.",
                                                  style: TextStyle(
                                                    color: AppColor.marianBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    quizes.values.elementAt(
                                                        index)['choice']['D'],
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.marianBlue,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Correct Option:",
                                                  style: TextStyle(
                                                    color: AppColor.marianBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    quizes.values.elementAt(
                                                        index)['ans'],
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColor.marianBlue,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
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
}
