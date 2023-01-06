import 'package:flutter_test/flutter_test.dart';
import 'package:tv/app/presentation/global/state_notifier.dart';

void main() {
  test(
    'StateNotifier',
    () {
      int counter = 0;
      final controller = _Controller('');
      controller.addListener(
        () {
          counter++;
        },
      );
      expect(controller.mounted, true);
      expect(controller.state, '');
      controller.update('');
      expect(counter, 0);
      controller.update('darwin');
      expect(controller.oldState, '');
      expect(counter, 1);
      controller.only('meedu');
      expect(counter, 1);
      expect(controller.state, 'meedu');
      controller.dispose();
      expect(controller.mounted, false);
    },
  );
}

class _Controller extends StateNotifier<String> {
  _Controller(super.state);

  void update(String newState) {
    state = newState;
  }

  void only(String newState) {
    onlyUpdate(newState);
  }
}
