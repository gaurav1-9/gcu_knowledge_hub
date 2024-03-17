import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../widgets/add_quiz_radiobtn.dart';
import '../widgets/headings.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';
import './add_quiz_screen.dart';
import 'admin_quiz_details_questions.dart';

class EditQuiz extends StatefulWidget {
  final String subName;
  final String courseID;
  final String subID;
  final String schID;
  final String questionID;
  final String question;
  final String questionNo;
  final String opA;
  final String opB;
  final String opC;
  final String opD;
  final String correctOption;
  const EditQuiz({
    super.key,
    required this.subName,
    required this.courseID,
    required this.subID,
    required this.schID,
    required this.questionID,
    required this.question,
    required this.opA,
    required this.opB,
    required this.opC,
    required this.opD,
    required this.correctOption,
    required this.questionNo,
  });

  @override
  State<EditQuiz> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  bool isLoading = false;
  late String courseID;
  late String subID;
  late String schID;
  late String questionID;
  late String subName;

  AddQuizStatus isEditQuizSuccess = AddQuizStatus.neutral;
  late String correctOption;
  late String questionUpdate;
  late String optionAUpdate;
  late String optionBUpdate;
  late String optionCUpdate;
  late String optionDUpdate;

  @override
  void initState() {
    super.initState();
    courseID = widget.courseID;
    subID = widget.subID;
    schID = widget.schID;
    subName = widget.subName;
    questionID = widget.questionID;
    correctOption = widget.correctOption;
    questionUpdate = widget.question;
    optionAUpdate = widget.opA;
    optionBUpdate = widget.opB;
    optionCUpdate = widget.opC;
    optionDUpdate = widget.opD;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Headings(
                primaryText: "Edit Quiz",
                secondaryTextFirst: "Q",
                secondaryText: "uestion",
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Subject Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.marianBlue,
                        height: 1,
                      ),
                    ),
                    Text(
                      "${widget.subName} (Question ${widget.questionNo})",
                      style: const TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppColor.marianBlue,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColor.marianBlue,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: questionUpdate,
                onChanged: (value) {
                  questionUpdate = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  focusColor: AppColor.marianBlue,
                  hintText: "Edit question",
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
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: optionAUpdate,
                onChanged: (value) {
                  optionAUpdate = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  focusColor: AppColor.marianBlue,
                  hintText: "Edit option A",
                  prefixIcon: Icon(
                    LucideIcons.circleDot,
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
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: optionBUpdate,
                onChanged: (value) {
                  optionBUpdate = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  focusColor: AppColor.marianBlue,
                  hintText: "Edit option B",
                  prefixIcon: Icon(
                    LucideIcons.circleDot,
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
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: optionCUpdate,
                onChanged: (value) {
                  optionCUpdate = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  focusColor: AppColor.marianBlue,
                  hintText: "Edit option C",
                  prefixIcon: Icon(
                    LucideIcons.circleDot,
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
                height: 20,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                initialValue: optionDUpdate,
                onChanged: (value) {
                  optionDUpdate = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  focusColor: AppColor.marianBlue,
                  hintText: "Edit option D",
                  prefixIcon: Icon(
                    LucideIcons.circleDot,
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
              const Row(
                children: [
                  Text(
                    "Edit the correct option:",
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            correctOption = value!;
                          });
                        },
                        value: "A",
                        correctOption: correctOption,
                      ),
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            correctOption = value!;
                          });
                        },
                        value: "B",
                        correctOption: correctOption,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            correctOption = value!;
                          });
                        },
                        value: "C",
                        correctOption: correctOption,
                      ),
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            correctOption = value!;
                          });
                        },
                        value: "D",
                        correctOption: correctOption,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    (isEditQuizSuccess == AddQuizStatus.success)
                        ? const Text(
                            "Question edited successfully",
                            style: TextStyle(
                              color: AppColor.forestGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : (isEditQuizSuccess == AddQuizStatus.emptyFields)
                            ? const Text(
                                "All input fields are required",
                                style: TextStyle(
                                  color: AppColor.tomato,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : (isEditQuizSuccess == AddQuizStatus.serverError)
                                ? const Column(
                                    children: [
                                      Text(
                                        "Oops...there was some error",
                                        style: TextStyle(
                                          color: AppColor.tomato,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Check your network connectivity",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColor.tomato,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text("")
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 50,
                  width: 270,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.jonquil,
                      foregroundColor: AppColor.marianBlue,
                    ),
                    onPressed: () {
                      addQuizQuestion(
                        questionUpdate,
                        questionID,
                        optionAUpdate,
                        optionBUpdate,
                        optionCUpdate,
                        optionDUpdate,
                        correctOption,
                      );
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColor.marianBlue,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ADD QUESTION',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                LucideIcons.listPlus,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addQuizQuestion(
    String question,
    String questionID,
    String optionA,
    String optionB,
    String optionC,
    String optionD,
    String answer,
  ) async {
    setState(() {
      isLoading = true;
    });
    String editQuizURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$courseID/subjects/$subID/questions/$questionID.json";
    try {
      if (question.isNotEmpty &&
          optionA.isNotEmpty &&
          optionB.isNotEmpty &&
          optionC.isNotEmpty &&
          optionD.isNotEmpty &&
          correctOption.isNotEmpty) {
        Map<String, dynamic> questionDetails = {
          "ans": answer,
          "qName": question,
          "choice": {
            "A": optionA,
            "B": optionB,
            "C": optionC,
            "D": optionD,
          }
        };
        await http.put(
          Uri.parse(editQuizURL),
          body: jsonEncode(questionDetails),
        );
        isEditQuizSuccess = AddQuizStatus.success;
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return AdminQuizDetailsQuestions(
                  deptID: courseID,
                  schID: schID,
                  subID: subID,
                  subName: subName,
                );
              },
            ),
          );
        });
      } else {
        isEditQuizSuccess = AddQuizStatus.emptyFields;
      }
    } catch (e) {
      isEditQuizSuccess = AddQuizStatus.serverError;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isEditQuizSuccess = AddQuizStatus.neutral;
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }
}
