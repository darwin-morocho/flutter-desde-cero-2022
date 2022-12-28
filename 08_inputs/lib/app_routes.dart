import 'package:flutter/material.dart';
import 'package:inputs/pages/calendar_page.dart';
import 'package:inputs/pages/check_box_page.dart';
import 'package:inputs/pages/cupertino_calendar_page.dart';
import 'package:inputs/pages/keyboard_types_page.dart';
import 'package:inputs/pages/radio_page.dart';
import 'package:inputs/pages/slider_page.dart';
import 'package:inputs/pages/text_field_page.dart';
import 'package:inputs/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.textField: (_) => const TextFieldPage(),
    Routes.keyboardTypes: (_) => const KeyboardTypesPage(),
    Routes.checkBox: (_) => const CheckBoxPage(),
    Routes.radio: (_) => const RadioPage(),
    Routes.slider: (_) => const SliderPage(),
    Routes.calendar: (_) => const CalendarPage(),
    Routes.cupertinoCalendar: (_) => const CupertinoCalendarPage(),
  }; 
}
