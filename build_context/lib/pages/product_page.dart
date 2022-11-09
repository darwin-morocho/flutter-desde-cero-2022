import 'package:build_context/mixins/mounted_mixin.dart';
import 'package:build_context/pages/home_page.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget with MountedMixin {
  ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        key: widgetKey,
        child: const Center(
          child: Text('hi'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMessage(context),
      ),
    );
  }

  void _showMessage(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    }
  }
}
