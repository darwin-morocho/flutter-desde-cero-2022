import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/app/presentation/global/widgets/network_image.dart';

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
    NetworkImage;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const MyNetworkImage(
              url:
                  'https://cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/55QHEOQRQBEPTF5LRJK57MDEP4.jpg',
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
