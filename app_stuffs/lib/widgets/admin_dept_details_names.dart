import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcu_knowledge_hub/properties/global_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
          Text(
            firstHead,
            style: const TextStyle(
              color: AppColor.marianBlue,
              fontSize: 18,
            ),
          ),
          Text(
            secondHead,
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
              children: deptNames.entries.map((e) {
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
                              fontSize: 17,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print("Clicked edit btn of ${e.value}");
                                },
                                icon: const Icon(
                                  LucideIcons.edit,
                                  color: AppColor.marianBlue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  print("Clicked delete btn of ${e.value}");
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
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
