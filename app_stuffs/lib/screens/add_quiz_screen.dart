import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/add_quiz_input_fields.dart';
import '../widgets/add_quiz_radiobtn.dart';
import '../widgets/headings.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AddQuiz extends StatefulWidget {
  final String subName;
  final String courseID;
  final String subID;
  const AddQuiz({
    super.key,
    required this.subName,
    required this.courseID,
    required this.subID,
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
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColor.marianBlue,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              QuizAddQuestionChoice(
                question: _questionController,
                optA: _optionAController,
                optB: _optionBController,
                optC: _optionCController,
                optD: _optionDController,
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
                      setState(() {
                        isLoading = true;
                      });
                      print("Q: ${_questionController.text}");
                      print("A: ${_optionAController.text}");
                      print("B: ${_optionBController.text}");
                      print("C: ${_optionCController.text}");
                      print("D: ${_optionDController.text}");
                      print("Ans: $_correctOption");
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
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
}
