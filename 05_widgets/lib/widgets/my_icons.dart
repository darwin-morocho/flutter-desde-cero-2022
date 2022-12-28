import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../icons/custom_icons.dart';

class MyIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CustomIcons.like,
              size: 100,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
