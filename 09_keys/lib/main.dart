import 'package:flutter/material.dart';
import 'package:keys/pages/animated_text.dart';
import 'package:keys/pages/key_page.dart';
import 'package:keys/pages/list_keys_page.dart';
import 'package:keys/pages/list_page.dart';
import 'package:keys/pages/movable_widget_page.dart';
import 'package:keys/pages/numbers_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovableWidgetPage(),
    );
  }
}
