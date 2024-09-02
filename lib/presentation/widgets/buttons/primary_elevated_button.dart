import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todo/core/constants/app_colors.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final void Function() onPressed;
  final Color? backgroundColor;
  final double? radius;
  const PrimaryElevatedButton(
      {super.key,
      this.child,
      required this.onPressed,
      this.radius,
      this.backgroundColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width(),
      height: height ?? 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? appPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
