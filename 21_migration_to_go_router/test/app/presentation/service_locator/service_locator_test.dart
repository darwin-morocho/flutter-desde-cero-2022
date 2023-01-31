import 'package:flutter_test/flutter_test.dart';
import 'package:tv/app/presentation/service_locator/service_locator.dart';

void main() {
  tearDown(
    () {
      ServiceLocator.instance.clear();
    },
  );
  test(
    'ServiceLocator > put',
    () {
      expect(
        () {
          ServiceLocator.instance.find<String>();
        },
        throwsAssertionError,
      );

      final name = ServiceLocator.instance.put<String>(
        'Darwin',
      );
      expect(
        name,
        ServiceLocator.instance.find<String>(),
      );
    },
  );

  test(
    'ServiceLocator > put 2',
    () {
      ServiceLocator.instance.put('Darwin');
      ServiceLocator.instance.put(
        'Santiago',
        tag: 'name2',
      );
      final user = ServiceLocator.instance.put(
        IUser('Lulu'),
      );

      final name = ServiceLocator.instance.find<String>(
        tag: 'name2',
      );
      expect(ServiceLocator.instance.find<IUser>(), user);

      expect(
        ServiceLocator.instance.find<String>(),
        'Darwin',
      );
      expect(name, 'Santiago');
    },
  );
}

class IUser {
  final String name;

  IUser(this.name);
}
