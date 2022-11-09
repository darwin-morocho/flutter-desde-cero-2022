import 'dart:async';

import 'package:build_context/mixins/after_first_layout_mixin.dart';
import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterFirstLayoutMixin {
  int _counter = 30;
  final _textKey = GlobalKey();
  final _safeAreaKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print("🔥");
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        key: _safeAreaKey,
        child: Center(
          child: Text(
            '$_counter',
            key: _textKey,
            style: TextStyle(
              fontSize: _counter.toDouble(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
      ),
    );
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // print("✅");
        _printTextSize();
      },
    );
  }

  void _printTextSize() {
    final renderBox = _textKey.currentContext!.findRenderObject() as RenderBox;

    final position = renderBox.localToGlobal(
      Offset.zero,
      ancestor: _safeAreaKey.currentContext!.findRenderObject(),
    );
    print('position $position');

    print(renderBox.size);

    if(mounted){
      
    }
  }

  @override
  FutureOr<void> onAfterFirstLayout() {
    _printTextSize();
  }
}
