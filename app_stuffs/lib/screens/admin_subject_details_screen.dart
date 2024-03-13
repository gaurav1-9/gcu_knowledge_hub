import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../screens/circular_loading_screen.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/buttons/auth_login_btns.dart';
import '../widgets/gcu.dart';

enum ShowMsg {
  neutral,
  isEmpty,
  successfull,
  serverError,
}

class AdminSubjectSelectionDetails extends StatefulWidget {
  final String schID;
  final String branchID;
  final String schName;
  final String branchName;
  const AdminSubjectSelectionDetails({
    super.key,
    required this.schID,
    required this.branchID,
    required this.schName,
    required this.branchName,
  });

  @override
  State<AdminSubjectSelectionDetails> createState() =>
      _AdminSubjectSelectionDetailsState();
}

class _AdminSubjectSelectionDetailsState
    extends State<AdminSubjectSelectionDetails> {
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
        print(deptSubjects);
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
                                "Click on the + button to add more subjcts",
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
                      ),
                      itemCount: deptSubjects.length + 1,
                      itemBuilder: (context, index) {
                        if (index < deptSubjects.length) {
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
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          bottomSheetEdit(
                                            ctx: context,
                                            subName: deptSubjects.values
                                                .elementAt(index),
                                            subID: deptSubjects.keys
                                                .elementAt(index),
                                          );
                                        },
                                        icon: const Icon(
                                          LucideIcons.edit,
                                          color: AppColor.marianBlue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showAlertDialog(
                                            context: context,
                                            deptID: branchID,
                                            deptName: branchName,
                                            subName: deptSubjects.values
                                                .elementAt(index),
                                            subID: deptSubjects.keys
                                                .elementAt(index),
                                          );
                                        },
                                        icon: const Icon(
                                          LucideIcons.trash2,
                                          color: AppColor.marianBlue,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.15,
                            ),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: AppColor.jonquilLight),
                              onPressed: () {
                                bottomSheetAdd(
                                  ctx: context,
                                );
                              },
                              icon: const Icon(
                                LucideIcons.plus,
                                color: AppColor.marianBlue,
                                size: 30,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void bottomSheetAdd({required BuildContext ctx}) {
    showBottomSheet(
      backgroundColor: AppColor.jonquilLight,
      context: ctx,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.32,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "New subject for",
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: subNameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      focusColor: AppColor.marianBlue,
                      hintText: "New subject name",
                      prefixIcon: Icon(
                        LucideIcons.ruler,
                        color: AppColor.marianBlue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.marianBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 20,
                    ),
                    cursorColor: AppColor.marianBlue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (showMsg == ShowMsg.isEmpty)
                          ? const Text(
                              "Subject name cannot be empty",
                              style: TextStyle(
                                color: AppColor.tomato,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : (showMsg == ShowMsg.successfull)
                              ? const Text(
                                  "Subject added",
                                  style: TextStyle(
                                    color: AppColor.forestGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : (showMsg == ShowMsg.serverError)
                                  ? const Text(
                                      "Oops...couldn't reach the server",
                                      style: TextStyle(
                                        color: AppColor.tomato,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(""),
                    ],
                  ),
                  AuthLogin(
                    isLoading: isLoading,
                    btnType: "Add Subject",
                    iconType: LucideIcons.filePlus,
                    navigateTo: () async {
                      if (subNameController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                          showMsg = ShowMsg.neutral;
                        });

                        try {
                          String newDeptName = subNameController.text;
                          subNameController.text = '';
                          String addSubURL =
                              "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$branchID/subjects.json";

                          await http.post(
                            Uri.parse(addSubURL),
                            body: json.encode({"subName": newDeptName}),
                          );

                          setState(() {
                            showMsg = ShowMsg.successfull;
                          });
                        } catch (e) {
                          setState(() {
                            showMsg = ShowMsg.serverError;
                          });
                        } finally {
                          setState(() {
                            isLoading = false;
                          });

                          Future.delayed(const Duration(seconds: 1), () {
                            if (showMsg != ShowMsg.serverError) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return AdminSubjectSelectionDetails(
                                      branchID: branchID,
                                      schID: schID,
                                      schName: schName,
                                      branchName: branchName,
                                    );
                                  },
                                ),
                              );
                            }
                            setState(() {
                              showMsg = ShowMsg.neutral;
                            });
                          });
                        }
                      } else {
                        setState(() {
                          showMsg = ShowMsg.isEmpty;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            showMsg = ShowMsg.neutral;
                          });
                        });
                      }
                    },
                    alignment: MainAxisAlignment.center,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAlertDialog({
    required BuildContext context,
    required String deptName,
    required String deptID,
    required String subName,
    required String subID,
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
            'You want to delete $subName from $branchName department',
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
                  subName: branchName,
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
    required BuildContext ctx,
  }) async {
    String deleteURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$branchID/subjects/$subID.json";
    try {
      await http.delete(Uri.parse(deleteURL));
    } catch (e) {
      showMsg = ShowMsg.serverError;
    } finally {
      if (showMsg == ShowMsg.serverError) {
        Navigator.of(context).pop();
        showMsg = ShowMsg.neutral;
      } else {
        Navigator.pushReplacementNamed(context, "/admin_subject_details");
      }
    }
  }

  void bottomSheetEdit({
    required BuildContext ctx,
    required String subName,
    required String subID,
  }) {
    String updatedText = subName;
    showBottomSheet(
      backgroundColor: AppColor.jonquilLight,
      context: ctx,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit name of department",
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: updatedText,
                    onChanged: (value) {
                      updatedText = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      focusColor: AppColor.marianBlue,
                      hintText: "Edit department name",
                      prefixIcon: Icon(
                        LucideIcons.edit3,
                        color: AppColor.marianBlue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColor.marianBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 20,
                    ),
                    cursorColor: AppColor.marianBlue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (showMsg == ShowMsg.isEmpty)
                          ? const Text(
                              "Subject name cannot be empty",
                              style: TextStyle(
                                color: AppColor.tomato,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : (showMsg == ShowMsg.successfull)
                              ? const Text(
                                  "Subject edited",
                                  style: TextStyle(
                                    color: AppColor.forestGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : (showMsg == ShowMsg.serverError)
                                  ? const Text(
                                      "Oops...couldn't reach the server",
                                      style: TextStyle(
                                        color: AppColor.tomato,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Text(""),
                    ],
                  ),
                  AuthLogin(
                    isLoading: isLoading,
                    btnType: "Edit Department",
                    iconType: LucideIcons.clipboardEdit,
                    navigateTo: () async {
                      if (updatedText.isEmpty) {
                        setState(
                          () {
                            showMsg = ShowMsg.isEmpty;
                          },
                        );
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            showMsg = ShowMsg.neutral;
                          });
                        });
                      } else {
                        setState(() {
                          isLoading = true;
                          showMsg = ShowMsg.neutral;
                        });
                        try {
                          String editingURL =
                              "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$branchID/subjects/$subID.json";
                          await http.put(
                            Uri.parse(editingURL),
                            body: json.encode({"subName": updatedText}),
                          );
                          // print(editingURL);
                          setState(() {
                            showMsg = ShowMsg.successfull;
                          });
                        } catch (e) {
                          setState(() {
                            showMsg = ShowMsg.serverError;
                          });
                        } finally {
                          setState(() {
                            isLoading = false;
                          });

                          Future.delayed(const Duration(seconds: 1), () {
                            if (showMsg != ShowMsg.serverError) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return AdminSubjectSelectionDetails(
                                      branchID: branchID,
                                      schID: schID,
                                      schName: schName,
                                      branchName: branchName,
                                    );
                                  },
                                ),
                              );
                            }
                            setState(() {
                              showMsg = ShowMsg.neutral;
                            });
                          });
                        }
                      }
                    },
                    alignment: MainAxisAlignment.center,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
