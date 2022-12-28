import 'package:flutter/material.dart';

class MyListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const names = ["Darwin", "Lulu", "Pepe"];

    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemBuilder: (_, int index) {
          final name = names[index];
          return Container(
            height: 100,
            child: Text(name),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
          );
        },
        itemCount: names.length,
        separatorBuilder: (_, int index) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: Colors.black38,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${names[index].length}",
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: Colors.black38,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
