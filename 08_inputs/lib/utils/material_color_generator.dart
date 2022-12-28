import 'package:flutter/material.dart';

MaterialColor generateMaterialColor(Color color) {
  final Map<int, Color> swatch = {};
  for (int i = 0; i < 10; i++) {
    late int key;
    if (i == 0) {
      key = 50;
    } else {
      key = i * 100;
    }

    final opacity = (0.1 * i) + 0.1;

    swatch[key] = Color.fromRGBO(
      color.red,
      color.green,
      color.blue,
      opacity,
    );
  }

  return MaterialColor(color.value, swatch);
}
