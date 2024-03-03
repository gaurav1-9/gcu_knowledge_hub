import 'package:flutter/material.dart';

class AddQuizSubjects extends StatefulWidget {
  final String deptname;
  const AddQuizSubjects({super.key, required this.deptname});

  @override
  State<AddQuizSubjects> createState() => _AddQuizSubjectsState();
}

class _AddQuizSubjectsState extends State<AddQuizSubjects> {
  late String deptName;

  @override
  void initState() {
    super.initState();
    deptName = widget.deptname;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(deptName),
    );
  }
}
