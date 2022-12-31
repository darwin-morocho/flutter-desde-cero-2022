import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Streams',
    () {
      final stream = getMessage();
      expect(
        stream,
        emitsAnyOf(
          [
            emitsThrough('meedu'),
            emitsThrough('jaja'),
          ],
        ),
      );
    },
  );

  test(
    'Streams > StreamController',
    () {
      final controller = StreamController<int>.broadcast();

      expectLater(
        controller.stream,
        emitsInOrder(
          [0, 10, 20],
        ),
      );

      expectLater(
        controller.stream,
        neverEmits(100),
      );

      controller.add(0);
      controller.add(10);
      controller.add(20);

      controller.close();
    },
  );
}

Stream<String> getMessage() async* {
  yield 'hola';
  yield 'mundo';
  yield 'test';
  yield 'meedu';

  yield 'darwin morocho';
}
