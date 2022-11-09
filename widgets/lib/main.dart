import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';

import 'widgets/text.dart';
import 'widgets/container.dart';
import 'widgets/column.dart';
import 'widgets/row.dart';
import 'widgets/stack.dart';
import 'widgets/scaffold.dart';
import 'widgets/safe_area.dart';
import 'widgets/single_child_scroll_view.dart';
import 'widgets/list_view.dart';
import 'widgets/custom_font.dart';
import 'widgets/my_icons.dart';
import 'widgets/cupertino_scaffold.dart';
import 'widgets/my_images.dart';
import 'facebook_ui/facebook_ui.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (_) => const MyApp(),
      enabled: !kReleaseMode,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: FacebookUi(),
      theme: ThemeData(
        fontFamily: 'Nunito'
      ),
    );
  }
}
