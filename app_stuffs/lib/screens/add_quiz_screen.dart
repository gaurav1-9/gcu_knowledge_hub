import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/headings.dart';
import '../widgets/textfields/txt_fields.dart';
import '../properties/global_colors.dart';
import '../widgets/buttons/app_bar_back_btn.dart';
import '../widgets/gcu.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

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
                height: 40,
              ),
              InputTextField(
                hintText: "Question",
                fieldType: LucideIcons.fileQuestion,
                isPassword: false,
                textCapitalization: TextCapitalization.sentences,
                textController: _questionController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: "Option A",
                fieldType: LucideIcons.circleDot,
                isPassword: false,
                textCapitalization: TextCapitalization.sentences,
                textController: _optionAController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: "Option B",
                fieldType: LucideIcons.circleDot,
                isPassword: false,
                textCapitalization: TextCapitalization.sentences,
                textController: _optionBController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: "Option C",
                fieldType: LucideIcons.circleDot,
                isPassword: false,
                textCapitalization: TextCapitalization.sentences,
                textController: _optionCController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: "Option D",
                fieldType: LucideIcons.circleDot,
                isPassword: false,
                textCapitalization: TextCapitalization.sentences,
                textController: _optionDController,
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
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColor.marianBlue,
                          value: "A",
                          groupValue: _correctOption,
                          onChanged: (value) {
                            setState(() {
                              _correctOption = value!;
                            });
                          },
                          title: Text(
                            textAlign: TextAlign.start,
                            "Option A",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (_correctOption == "A")
                                  ? AppColor.marianBlue
                                  : AppColor.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColor.marianBlue,
                          value: "B",
                          groupValue: _correctOption,
                          onChanged: (value) {
                            setState(() {
                              _correctOption = value!;
                            });
                          },
                          title: Text(
                            "Option B",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (_correctOption == "B")
                                  ? AppColor.marianBlue
                                  : AppColor.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColor.marianBlue,
                          value: "C",
                          groupValue: _correctOption,
                          onChanged: (value) {
                            setState(() {
                              _correctOption = value!;
                            });
                          },
                          title: Text(
                            "Option C",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (_correctOption == "C")
                                  ? AppColor.marianBlue
                                  : AppColor.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColor.marianBlue,
                          value: "D",
                          groupValue: _correctOption,
                          onChanged: (value) {
                            setState(() {
                              _correctOption = value!;
                            });
                          },
                          title: Text(
                            "Option D",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (_correctOption == "D")
                                  ? AppColor.marianBlue
                                  : AppColor.grey,
                            ),
                          ),
                        ),
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
