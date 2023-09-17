import 'dart:math';

import 'package:flutter/material.dart';

class SizeLibrary {
  final BuildContext context;

  const SizeLibrary(this.context);

  // return diagonal size of the device
  double appSize(double size) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double diagonal = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
    final double appSize = (diagonal / 100) * size;

    return appSize / 6;
  }

  double appWidth(BuildContext context, double percentage) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (percentage / 100) * screenWidth;
  }
}
