import 'dart:io';

import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  String? _better;
  String? _gender;

  void _onBetterChanged(String? value) {
    setState(() {
      _better = value;
    });
  }

  void _onGenderChanged(String? value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text(
              'Witch is better?',
            ),
            RadioListTile<String>(
              value: 'flutter',
              groupValue: _better,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: const Text('flutter'),
              dense: true,
              onChanged: _onBetterChanged,
              activeColor: Colors.black,
            ),
            RadioListTile<String>(
              value: 'react native',
              groupValue: _better,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              dense: true,
              title: const Text('react native'),
              onChanged: _onBetterChanged,
            ),
            const Divider(),
            const Text(
              'What is your gender?',
            ),
            RadioListTile<String>(
              value: 'male',
              groupValue: _gender,
              onChanged: _onGenderChanged,
              title: const Text('male'),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              dense: true,
            ),
            RadioListTile<String>(
              value: 'female',
              groupValue: _gender,
              onChanged: _onGenderChanged,
              title: const Text('female'),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              dense: true,
            ),
            RadioListTile<String>(
              value: 'other',
              groupValue: _gender,
              onChanged: _onGenderChanged,
              title: const Text('other'),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
