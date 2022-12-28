import 'package:flutter/material.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({Key? key}) : super(key: key);

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  final List<int> _numbers = [];

  @override
  void initState() {
    super.initState();

    _numbers.addAll(
      List.generate(100, (index) => index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReorderableListView.builder(
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            _numbers.insert(
              newIndex,
              _numbers.removeAt(
                oldIndex,
              ),
            );
          },
          itemBuilder: (_, index) {
            final value = _numbers[index];

            return ListTile(
              key: ValueKey(value),
              title: Text(
                '$value',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          },
          itemCount: _numbers.length,
        ),
      ),
    );
  }
}
