import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _initialDate, _date;

  @override
  void initState() {
    super.initState();
    _initialDate = DateTime(1993, 4, 10);
    _date = _initialDate;

    while (!_selectableDayPredicate(_initialDate)) {
      _initialDate = _initialDate.add(
        const Duration(days: 1),
      );
      _date = _initialDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _selectTime,
            icon: const Icon(Icons.watch),
          ),
          IconButton(
            onPressed: _selectDate,
            icon: const Icon(Icons.calendar_month),
          ),
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: CalendarDatePicker(
          initialDate: _date,
          firstDate: DateTime(1900, 5),
          lastDate: DateTime.now(),
          // initialCalendarMode: DatePickerMode.year,
          onDateChanged: (date) {
            _date = date;
          },
          selectableDayPredicate: _selectableDayPredicate,
        ),
      ),
    );
  }

  bool _selectableDayPredicate(DateTime date) {
    return date.weekday != 6 && date.weekday != 7;
  }

  void _save() {
    if (_initialDate != _date) {
      ///
      print(_date);
    }
    Navigator.pop(context);
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      builder: (_, child) => WillPopScope(
        child: child!,
        onWillPop: () async => false,
      ),
      firstDate: DateTime(1900, 5),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (date != null) {
      setState(() {
        _date = date;
      });
    }
  }

  void _selectTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      builder: (_, child) {
        return WillPopScope(
          child: child!,
          onWillPop: () async => false,
        );
      },
      initialTime: const TimeOfDay(
        hour: 0,
        minute: 0,
      ),
      hourLabelText: "hora",
      minuteLabelText: "Minutos",
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null) {
      print(timeOfDay);
    }
  }
}
