import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminDepartment extends StatelessWidget {
  final String firstHead;
  final String secondHead;
  final Map<String, dynamic> deptNames;
  const AdminDepartment({
    super.key,
    required this.firstHead,
    required this.secondHead,
    required this.deptNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(firstHead),
          Text(secondHead),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: deptNames.entries.map((e) {
                return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text("${e.value}"));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
