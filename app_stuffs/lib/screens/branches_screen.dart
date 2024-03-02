import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gcu_knowledge_hub/widgets/under_development.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';

import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/headings.dart';
import 'circular_loading_screen.dart';

class BranchSchool extends StatefulWidget {
  final String schName;
  const BranchSchool({super.key, required this.schName});

  @override
  State<BranchSchool> createState() => _BranchSchoolState();
}

class _BranchSchoolState extends State<BranchSchool> {
  bool isLoading = true;
  late Map routeArgs;
  Map<String, dynamic> branchNames = {};

  void getBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/branches/${widget.schName}.json";
    final response = await http
        .get(Uri.parse(branchURL))
        .timeout(const Duration(seconds: 10));
    try {
      if (jsonDecode(response.body) != null) {
        Map<String, dynamic> branchData = jsonDecode(response.body);
        branchNames.addAll(branchData);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getBranch();
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
                primaryText: "Branch",
                secondaryTextFirst: "S",
                secondaryText: "election",
              ),
              const SizedBox(
                height: 40,
              ),
              (branchNames.isEmpty)
                  ? const UnderDevelopment()
                  : Column(
                      children: branchNames.entries.map((entry) {
                        return Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                backgroundColor: AppColor.jonquil,
                                foregroundColor: AppColor.marianBlue,
                              ),
                              onPressed: () {
                                print(
                                  "Button pressed(${entry.key}): ${entry.value}",
                                );
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
        )),
      );
    }
  }
}
