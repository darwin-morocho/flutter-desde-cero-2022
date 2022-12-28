import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:navigation/app_routes.dart';
import 'package:navigation/pages/login_page.dart';

import 'routes.dart';

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
      initialRoute: Routes.initialRoute,
      routes: appRoutes,
    );
  }
}

