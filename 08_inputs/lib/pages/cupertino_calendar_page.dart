import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoCalendarPage extends StatefulWidget {
  const CupertinoCalendarPage({Key? key}) : super(key: key);

  @override
  State<CupertinoCalendarPage> createState() => _CupertinoCalendarPageState();
}

class _CupertinoCalendarPageState extends State<CupertinoCalendarPage> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime(2021);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime(1900),
                initialDateTime: _date,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) {
                  setState(() {
                    _date = date;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
