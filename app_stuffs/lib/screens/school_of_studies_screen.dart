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
  late Map<String, dynamic> schoolNames = {};
  Map<String, dynamic> data = {};
  bool isLoading = true;

  void getSchools() async {
    const schoolURL =
        "https://gcu-knowledge-hub-1a7b9-default-rtdb.firebaseio.com/schools.json";
    final response = await http.get(Uri.parse(schoolURL));
    try {
      data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        schoolNames.addAll(
            {data.keys.elementAt(i): data.values.elementAt(i)['schName']});
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToBranches(String schoolID) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BranchSchool(schID: schoolID);
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
                            fixedSize: Size(
                              MediaQuery.of(context).size.width * .7,
                              MediaQuery.of(context).size.width * .18,
                            ),
                            backgroundColor: AppColor.jonquil,
                            foregroundColor: AppColor.marianBlue,
                          ),
                          onPressed: () {
                            navigateToBranches(entry.key);
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
