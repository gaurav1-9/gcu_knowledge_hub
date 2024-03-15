import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/headings.dart';
import './admin_subject_details_screen.dart';
import './circular_loading_screen.dart';

class AdminSubjectDetails extends StatefulWidget {
  const AdminSubjectDetails({super.key});

  @override
  State<AdminSubjectDetails> createState() => _AdminSubjectDetailsState();
}

class _AdminSubjectDetailsState extends State<AdminSubjectDetails> {
  bool isLoading = true;
  Map<String, dynamic> schoolNames = {};

  void getAllBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools.json";
    final response = await http.get(Uri.parse(branchURL));

    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> rawData = jsonDecode(response.body);
        for (int i = 0; i < rawData.length; i++) {
          Map<String, dynamic> deptTemp = {};
          for (int j = 0;
              j < rawData.values.elementAt(i)['branchNames'].length;
              j++) {
            deptTemp.addAll({
              rawData.values.elementAt(i)['branchNames'].keys.elementAt(j):
                  rawData.values
                      .elementAt(i)['branchNames']
                      .values
                      .elementAt(j)['dept']
            });
          }
          schoolNames.addAll({
            "${rawData.keys.elementAt(i)}_${rawData.values.elementAt(i)['schName']}":
                deptTemp,
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
    getAllBranch();
    super.initState();
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
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Headings(
                        primaryText: "Subject",
                        secondaryTextFirst: 'D',
                        secondaryText: "etails",
                        secHeight: 1,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ...schoolNames.entries.map((entry) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'School of',
                                      style: TextStyle(
                                        color: AppColor.marianBlue,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      entry.key.split("_")[1],
                                      style: const TextStyle(
                                        color: AppColor.marianBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      ...entry.value.entries.map((e) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 20,
                                            right: 20,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColor.jonquil,
                                              foregroundColor:
                                                  AppColor.marianBlue,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return AdminSubjectSelectionDetails(
                                                  branchID: e.key,
                                                  schID:
                                                      entry.key.split("_")[0],
                                                  schName:
                                                      entry.key.split("_")[1],
                                                  branchName: e.value,
                                                );
                                              }));
                                            },
                                            child: Text(
                                              e.value,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                )
                              ]),
                        );
                      }).toList(),
                    ]),
              ),
            ),
          );
  }
}
