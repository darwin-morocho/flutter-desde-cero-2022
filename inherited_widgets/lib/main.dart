import 'package:flutter/material.dart';
import 'package:inherited_widgets/global/theme_controller.dart';
import 'package:inherited_widgets/state_management/consumer.dart';
import 'package:inherited_widgets/state_management/provider.dart';

import 'pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ThemeController>(
      child: Consumer<ThemeController>(
        builder: (_, controller) => MaterialApp(
          title: 'Flutter Demo',
          home: const MyHomePage(),
          theme: controller.isDarkModeEnabled
              ? ThemeData.dark()
              : ThemeData.light(),
        ),
      ),
      create: () => ThemeController(),
    );
  }
}
