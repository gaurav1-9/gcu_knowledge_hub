import 'package:flutter/material.dart';

import '../../properties/global_colors.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final IconData fieldType;
  final bool isPassword;
  final TextEditingController textController;
  final TextCapitalization textCapitalization;

  const InputTextField({
    super.key,
    required this.hintText,
    required this.fieldType,
    required this.isPassword,
    required this.textController,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      controller: textController,
      obscureText: isPassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 5,
        ),
        focusColor: AppColor.marianBlue,
        hintText: hintText,
        prefixIcon: Icon(
          fieldType,
          color: AppColor.marianBlue,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
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
    );
  }
}
