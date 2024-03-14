import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/buttons/auth_login_btns.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';

enum ShowMsg {
  neutral,
  isEmpty,
  successfull,
  serverError,
}

class AdminDepartment extends StatefulWidget {
  final String firstHead;
  final String secondHead;
  final Map<String, dynamic> deptNames;
  final String schName;
  const AdminDepartment({
    super.key,
    required this.firstHead,
    required this.secondHead,
    required this.deptNames,
    required this.schName,
  });

  @override
  State<AdminDepartment> createState() => _AdminDepartmentState();
}

class _AdminDepartmentState extends State<AdminDepartment> {
  ShowMsg showMsg = ShowMsg.neutral;
  bool isLoading = false;
  TextEditingController deptNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.firstHead,
            style: const TextStyle(
              color: AppColor.marianBlue,
              fontSize: 18,
            ),
          ),
          Text(
            widget.secondHead,
            style: const TextStyle(
              color: AppColor.marianBlue,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                ...widget.deptNames.entries.map((e) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: const EdgeInsets.only(right: 10),
                    child: Card(
                      color: AppColor.jonquil,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.value,
                              style: const TextStyle(
                                color: AppColor.marianBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    bottomSheetEdit(
                                      schID: widget.schName.split("_")[0],
                                      branchID: e.key,
                                      branchName: e.value,
                                      ctx: context,
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
                                      context,
                                      e.value,
                                      e.key,
                                      widget.schName,
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
                    ),
                  );
                }).toList(),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.08,
                  backgroundColor: AppColor.jonquilLight,
                  child: IconButton(
                    onPressed: () {
                      bottomSheetAdd(widget.schName.split("_")[0],
                          widget.schName.split("_")[1], context);
                    },
                    icon: const Icon(
                      LucideIcons.plus,
                      color: AppColor.marianBlue,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(
    BuildContext context,
    String deptName,
    String deptID,
    String schName,
  ) {
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
            'You want to delete $deptName department',
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
                deleteDept(deptName, schName.split("_")[0], deptID, context);
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

  void bottomSheetEdit({
    required String schID,
    required String branchID,
    required String branchName,
    required BuildContext ctx,
  }) {
    String updatedText = branchName;
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
                              "Department name cannot be empty",
                              style: TextStyle(
                                color: AppColor.tomato,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : (showMsg == ShowMsg.successfull)
                              ? const Text(
                                  "Department edited",
                                  style: TextStyle(
                                    color: AppColor.forestGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : (showMsg == ShowMsg.serverError)
                                  ? const Text(
                                      "Oops...could'nt reach the server",
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
                              "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$branchID.json";
                          await http.put(
                            Uri.parse(editingURL),
                            body: json.encode({"dept": updatedText}),
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
                              Navigator.pushReplacementNamed(
                                  context, '/admin_dept_details');
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

  void bottomSheetAdd(String schID, String schName, BuildContext ctx) {
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
                    "New department for",
                    style: TextStyle(
                      color: AppColor.marianBlue,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    schName,
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
                    controller: deptNameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      focusColor: AppColor.marianBlue,
                      hintText: "New department name",
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
                              "Department name cannot be empty",
                              style: TextStyle(
                                color: AppColor.tomato,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : (showMsg == ShowMsg.successfull)
                              ? const Text(
                                  "Department added",
                                  style: TextStyle(
                                    color: AppColor.forestGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : (showMsg == ShowMsg.serverError)
                                  ? const Text(
                                      "Oops...could'nt reach the server",
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
                    btnType: "Add Department",
                    iconType: LucideIcons.filePlus,
                    navigateTo: () async {
                      if (deptNameController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                          showMsg = ShowMsg.neutral;
                        });

                        try {
                          String newDeptName = deptNameController.text;
                          deptNameController.text = '';
                          String addDeptURL =
                              "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames.json";

                          await http.post(
                            Uri.parse(addDeptURL),
                            body: json.encode({"dept": newDeptName}),
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
                              Navigator.pushReplacementNamed(
                                  context, '/admin_dept_details');
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

  void deleteDept(
    String deptName,
    String schID,
    String deptID,
    BuildContext ctx,
  ) async {
    String deleteURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$deptID.json";
    try {
      await http.delete(Uri.parse(deleteURL));
    } catch (e) {
      showMsg = ShowMsg.serverError;
    } finally {
      if (showMsg == ShowMsg.serverError) {
        Navigator.of(context).pop();
        showMsg = ShowMsg.neutral;
      } else {
        Navigator.of(context).pushReplacementNamed('/admin_dept_details');
      }
    }
  }
}
