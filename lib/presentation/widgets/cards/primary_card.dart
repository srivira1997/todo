import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_colors.dart';

class PrimaryCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? borderRadius;
  const PrimaryCard(
      {super.key, this.child, this.margin, this.color, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? appCardBackColor,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
      ),
      child: child,
    );
  }
}
