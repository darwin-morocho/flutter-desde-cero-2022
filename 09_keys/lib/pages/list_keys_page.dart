import 'package:flutter/material.dart';
import 'package:keys/widgets/counter_button.dart';

class ListKeysPage extends StatefulWidget {
  const ListKeysPage({Key? key}) : super(key: key);

  @override
  State<ListKeysPage> createState() => _ListKeysPageState();
}

class _ListKeysPageState extends State<ListKeysPage> {
  bool _enabledEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Switch(
            value: _enabledEmail,
            onChanged: (value) {
              setState(() {
                _enabledEmail = value;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          if (_enabledEmail)
            const TextField(
              decoration: InputDecoration(
                label: Text('Email'),
              ),
            ),
          const TextField(
            key: Key('password'),
            decoration: InputDecoration(
              label: Text('Password'),
            ),
          ),
          const CounterButton(
            key: Key('counter1'),
          ),
          const CounterButton(
            key: Key('counter2'),
          ),
        ],
      ),
    );
  }
}
