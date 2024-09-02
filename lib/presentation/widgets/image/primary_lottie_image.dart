import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PrimaryLottieImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const PrimaryLottieImage(
      {super.key, required this.path, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(path, width: width, height: height, fit: fit);
  }
}
