import 'package:flutter/material.dart';

class KeyboardTypesPage extends StatelessWidget {
  const KeyboardTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Email'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          const TextField(
            enabled: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              label: Text('Phone'),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: InputDecoration(
              label: Text('Price'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              label: Text('Name'),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) {
              print('🔥');
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('send'),
          ),
        ],
      ),
    );
  }
}
