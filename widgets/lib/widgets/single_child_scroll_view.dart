import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final containers = List.generate(
      18,
      (index) => Container(
        color: Colors.primaries[index],
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Text("$index"),
      ),
    );

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          child: Column(
            children: [
              Container(
                height: 100,
                child: Row(
                  children: [
                    FlutterLogo(
                      size: 90,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: containers,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(),
                        ),
                        ...containers,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
