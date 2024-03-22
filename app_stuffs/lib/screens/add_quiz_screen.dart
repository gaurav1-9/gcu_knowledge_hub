import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

import '../widgets/add_quiz_input_fields.dart';
import '../widgets/add_quiz_radiobtn.dart';
import '../widgets/headings.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

enum AddQuizStatus {
  success,
  serverError,
  neutral,
  emptyFields,
}

class AddQuiz extends StatefulWidget {
  final String subName;
  final String courseID;
  final String subID;
  final String schID;
  const AddQuiz({
    super.key,
    required this.subName,
    required this.courseID,
    required this.subID,
    required this.schID,
  });

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionAController = TextEditingController();
  final TextEditingController _optionBController = TextEditingController();
  final TextEditingController _optionCController = TextEditingController();
  final TextEditingController _optionDController = TextEditingController();
  String _correctOption = '';
  bool isLoading = false;
  late String courseID;
  late String subID;
  late String schID;
  late String subName;
  AddQuizStatus isAddQuizSuccess = AddQuizStatus.neutral;
  File? questionImage;

  @override
  void initState() {
    super.initState();
    courseID = widget.courseID;
    subID = widget.subID;
    schID = widget.schID;
    subName = widget.subName;
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
                primaryText: "Add Quiz",
                secondaryTextFirst: "Q",
                secondaryText: "uestion",
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
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
                    widget.subName,
                    style: const TextStyle(
                      height: 1.3,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: AppColor.marianBlue,
                    ),
                  ),
                  const Divider(
                    color: AppColor.marianBlue,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              QuizAddQuestionChoice(
                question: _questionController,
                optA: _optionAController,
                optB: _optionBController,
                optC: _optionCController,
                optD: _optionDController,
                imageFunc: popUpImageCaptureDevice,
                questionImage: questionImage,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Which option is the correct answer?",
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
                            _correctOption = value!;
                          });
                        },
                        value: "A",
                        correctOption: _correctOption,
                      ),
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            _correctOption = value!;
                          });
                        },
                        value: "B",
                        correctOption: _correctOption,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            _correctOption = value!;
                          });
                        },
                        value: "C",
                        correctOption: _correctOption,
                      ),
                      QuizAddRadio(
                        selctionFunction: (value) {
                          setState(() {
                            _correctOption = value!;
                          });
                        },
                        value: "D",
                        correctOption: _correctOption,
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    (isAddQuizSuccess == AddQuizStatus.success)
                        ? const Text(
                            "Question added successfully",
                            style: TextStyle(
                              color: AppColor.forestGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : (isAddQuizSuccess == AddQuizStatus.emptyFields)
                            ? const Text(
                                "All input fields are required",
                                style: TextStyle(
                                  color: AppColor.tomato,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : (isAddQuizSuccess == AddQuizStatus.serverError)
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
                        _questionController.text,
                        _optionAController.text,
                        _optionBController.text,
                        _optionCController.text,
                        _optionDController.text,
                        _correctOption,
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

  void popUpImageCaptureDevice() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: AppColor.jonquilLight,
            title: const Text(
              "Select your preference",
              style: TextStyle(
                fontSize: 35,
                color: AppColor.marianBlue,
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    addQuestionImage(ImageSource.camera);
                  },
                  icon: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.camera,
                          color: AppColor.marianBlue,
                          size: MediaQuery.of(context).size.height * 0.1,
                        ),
                        const Text(
                          "Camera",
                          style: TextStyle(
                            color: AppColor.marianBlue,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    addQuestionImage(ImageSource.gallery);
                  },
                  icon: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.image,
                          color: AppColor.marianBlue,
                          size: MediaQuery.of(context).size.height * 0.1,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                            color: AppColor.marianBlue,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void addQuestionImage(ImageSource sourceType) async {
    ImagePicker imagePicker = ImagePicker();
    final imagePicked = await imagePicker.pickImage(source: sourceType);
    if (imagePicked != null) {
      setState(() {
        questionImage = File(imagePicked.path);
      });
    }
  }

  void addQuizQuestion(
    String question,
    String optionA,
    String optionB,
    String optionC,
    String optionD,
    String answer,
  ) async {
    setState(() {
      isLoading = true;
    });
    String addQuizURL =
        "https://gcu-knowledge-hub-default-rtdb.firebaseio.com/schools/$schID/branchNames/$courseID/subjects/$subID/questions.json";
    try {
      if ((question.isNotEmpty || questionImage != null) &&
          optionA.isNotEmpty &&
          optionB.isNotEmpty &&
          optionC.isNotEmpty &&
          optionD.isNotEmpty &&
          answer.isNotEmpty) {
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
        // final imgRef = FirebaseStorage.instance
        //     .ref()
        //     .child('${schID}_${widget.subName}')
        //     .child('${courseID}_${widget.subName}');

        // await http.post(
        //   Uri.parse(addQuizURL),
        //   body: jsonEncode(questionDetails),
        // );
        isAddQuizSuccess = AddQuizStatus.success;
        _questionController.text = '';
        _optionAController.text = '';
        _optionBController.text = '';
        _optionCController.text = '';
        _optionDController.text = '';
        _correctOption = '';
        setState(() {
          questionImage = null;
        });
      } else {
        isAddQuizSuccess = AddQuizStatus.emptyFields;
      }
    } catch (e) {
      isAddQuizSuccess = AddQuizStatus.serverError;
    } finally {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isAddQuizSuccess = AddQuizStatus.neutral;
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }
}
