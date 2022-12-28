import 'package:flutter/material.dart';

import 'material_color_generator.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: generateMaterialColor(
      const Color.fromARGB(255, 13, 56, 247),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        Colors.pinkAccent,
      ),
      checkColor: MaterialStateProperty.all(
        Colors.white,
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.blueGrey.withOpacity(0.2),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Colors.pinkAccent,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
        Colors.amber,
      ),
      trackColor: MaterialStateProperty.all(
        Colors.amber,
      ),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 15,
      activeTrackColor: Colors.pinkAccent,
      thumbColor: Colors.pink,
      overlayColor: Colors.pink.withOpacity(0.1),
      valueIndicatorColor: Colors.redAccent,
      inactiveTrackColor: Colors.pinkAccent.withOpacity(0.2),
      inactiveTickMarkColor: Colors.white54,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 15,
      ),
    ),
  );
}
