import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (_, orientation) {
          final listView = ListView.builder(
            key: listKey,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text('$index'),
              );
            },
            itemCount: 1000,
          );

          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                const Text('PORTRAIT'),
                Expanded(
                  child: listView,
                ),
              ],
            );
          }

          return Row(
            children: [
              const Expanded(
                child: Text('LANDSCAPE'),
              ),
              Expanded(
                child: listView,
              ),
            ],
          );
        },
      ),
    );
  }
}
