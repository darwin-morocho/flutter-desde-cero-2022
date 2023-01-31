import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get darkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}
