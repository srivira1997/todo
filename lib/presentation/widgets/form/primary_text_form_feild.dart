import 'package:flutter/material.dart';

import 'package:todo/core/constants/app_colors.dart';

class PrimaryTextFormFeild extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  const PrimaryTextFormFeild(
      {super.key,
      this.hintText,
      this.validator,
      this.controller,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: false,
      maxLines: maxLines,
      autocorrect: false,
      style: const TextStyle(
          color: appWhiteColor,
          decoration: TextDecoration.none,
          decorationThickness: 0),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        fillColor: appWhiteColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          gapPadding: 1.0,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
