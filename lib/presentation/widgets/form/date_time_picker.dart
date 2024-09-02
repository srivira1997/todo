import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todo/core/constants/app_colors.dart';

class DatePicker extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final double? height;
  final double? fontSize;
  final double? hintfontSize;
  final String? Function(String?)? validator;
  const DatePicker(
      {super.key,
      required this.hintText,
      required this.controller,
      this.onChanged,
      this.margin,
      this.decoration,
      this.height,
      this.validator,
      this.fontSize,
      this.hintfontSize});

  @override
  State<DatePicker> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
          color: appWhiteColor,
          decoration: TextDecoration.none,
          decorationThickness: 0),
      decoration: InputDecoration(
        hintText: widget.hintText,
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
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));

        if (pickeddate != null) {
          widget.controller.text = pickeddate.toString();
          //DateFormat('dd-MMM-yyy').format(pickeddate);
        }
      },
    ).paddingOnly(left: 5, right: 5);
  }
}
