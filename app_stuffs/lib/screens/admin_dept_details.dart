import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/admin_dept_details_names.dart';
import '../screens/circular_loading_screen.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import '../widgets/headings.dart';

class AdminDeptDetails extends StatefulWidget {
  const AdminDeptDetails({super.key});

  @override
  State<AdminDeptDetails> createState() => _AdminDeptDetailsState();
}

class _AdminDeptDetailsState extends State<AdminDeptDetails> {
  bool isLoading = true;
  Map<String, dynamic> schoolNames = {};

  void getAllBranch() async {
    String branchURL =
        "https://gcu-knowledge-hub-1a7b9-default-rtdb.firebaseio.com/schools.json";
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
                        primaryText: "Department",
                        secondaryTextFirst: 'D',
                        secondaryText: "etails",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ...schoolNames.entries.map((entry) {
                        return AdminDepartment(
                          firstHead: 'School of',
                          secondHead: entry.key.split("_")[1],
                          deptNames: entry.value,
                          schName: entry.key,
                        );
                      }).toList(),
                    ]),
              ),
            ),
          );
  }
}
