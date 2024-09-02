import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  const PrimaryText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          color: color ?? appWhiteColor,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w400),
    );
  }
}
