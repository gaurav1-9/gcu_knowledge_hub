import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcu_knowledge_hub/properties/global_colors.dart';

class MCQOptions extends StatelessWidget {
  final String optionNo;
  final String choiceDesc;
  const MCQOptions(
      {super.key, required this.optionNo, required this.choiceDesc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(optionNo),
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.07,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.fromBorderSide(
            BorderSide(
              width: 1,
              color: AppColor.grey,
            ),
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                optionNo,
                style: const TextStyle(
                  color: AppColor.marianBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  choiceDesc,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: AppColor.marianBlue,
                    fontSize: 16,
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
