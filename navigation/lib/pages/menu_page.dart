import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:navigation/pages/color_picker.dart';

import '../routes.dart';
import 'login_page.dart';

class PageData {
  final String name;
  final String label;
  final Object? arguments;
  final void Function(Object?)? onResult;

  const PageData({
    required this.name,
    required this.label,
    this.arguments,
    this.onResult,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color _color = Colors.red;

  late final List<PageData> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PageData(
        name: Routes.login,
        label: 'go to login',
        arguments: 'test@test.com',
      ),
      const PageData(
        name: Routes.counter,
        label: 'go to counter',
      ),
      PageData(
        name: Routes.colorPicker,
        label: 'pick color',
        onResult: (result) {
          if (result is Color) {
            _color = result;
            setState(() {});
          }
        },
      ),
      const PageData(
        name: Routes.dialogs,
        label: 'go to dialogs',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          final data = _pages[index];
          return ListTile(
            title: Text(data.label),
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                data.name,
                arguments: data.arguments,
              );
              if (data.onResult != null) {
                data.onResult!(result);
              }
            },
          );
        },
        itemCount: _pages.length,
      ),
    );
  }
}
