import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../properties/global_colors.dart';
import '../widgets/headings.dart';
import '../screens/branches_screen.dart';
import './circular_loading_screen.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class SchoolOfStudies extends StatefulWidget {
  const SchoolOfStudies({super.key});

  @override
  State<SchoolOfStudies> createState() => _SchoolOfStudiesState();
}

class _SchoolOfStudiesState extends State<SchoolOfStudies> {
  late final Map<String, dynamic> schoolNames = {};
  bool isLoading = true;

  void getSchools() async {
    const schoolURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools.json";
    final response = await http.get(Uri.parse(schoolURL));
    try {
      Map<String, dynamic> schoolsData = jsonDecode(response.body);
      schoolNames.addAll(schoolsData);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToBranches(String school) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BranchSchool(schName: school);
        },
      ),
    );
  }

  @override
  void initState() {
    getSchools();
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
                  primaryText: "School",
                  secondaryTextFirst: "O",
                  secondaryText: "f Studies",
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: schoolNames.entries.map((entry) {
                    return Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(250, 60),
                            backgroundColor: AppColor.jonquil,
                            foregroundColor: AppColor.marianBlue,
                          ),
                          onPressed: () {
                            switch (entry.value) {
                              case "Engineering & Tech":
                                navigateToBranches("engineering_tech");
                                break;
                              case "Management & Commerce":
                                navigateToBranches("mgmnt_comm");
                                break;
                              case "Humanities & Social Science":
                                navigateToBranches("arts");
                                break;
                            }
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
          ),
        ),
      );
    }
  }
}