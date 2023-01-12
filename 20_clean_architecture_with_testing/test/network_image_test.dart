import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Network Image',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CounterView(),
        ),
      );
      expect(
        find.text('0'),
        findsOneWidget,
      );
      await tester.tap(
        find.byType(FloatingActionButton),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('1'),
        findsOneWidget,
      );
    },
  );
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/55QHEOQRQBEPTF5LRJK57MDEP4.jpg',
              placeholder: (_, __) => const CircularProgressIndicator(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                counter.toString(),
                key: UniqueKey(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
      ),
    );
  }
}
