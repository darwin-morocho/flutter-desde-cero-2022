import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            FlutterLogo(
              size: 100,
            ),
            FlutterLogo(
              size: 100,
            ),
            Spacer(),
            FlutterLogo(
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
