import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/repositories_implementation/preferences_repository_impl.dart';
import 'package:tv/app/domain/enums.dart';

import '../../../mocks.dart';

void main() {
  group(
    'PreferencesRepositoryImpl >',
    () {
      test(
        'get darkMode > true',
        () async {
          final preferences = MockSharedPreferences();
          when(
            preferences.getBool(Preference.darkMode.name),
          ).thenReturn(true);

          final repository = PreferencesRepositoryImpl(
            preferences,
            false,
          );
          expect(repository.darkMode, true);
        },
      );
      test(
        'get darkMode > false',
        () async {
          final preferences = MockSharedPreferences();
          when(
            preferences.getBool(Preference.darkMode.name),
          ).thenReturn(false);

          final repository = PreferencesRepositoryImpl(
            preferences,
            true,
          );
          expect(repository.darkMode, false);
        },
      );

      test(
        'setDarkMode',
        () async {
          final preferences = MockSharedPreferences();
          bool? darkMode;
          when(
            preferences.getBool(Preference.darkMode.name),
          ).thenAnswer(
            (_) => darkMode,
          );

          when(
            preferences.setBool(Preference.darkMode.name, any),
          ).thenAnswer(
            (invocation) async {
              darkMode = invocation.positionalArguments.last;
              return darkMode!;
            },
          );

          final repository = PreferencesRepositoryImpl(
            preferences,
            false,
          );

          expect(repository.darkMode, false);

          await repository.setDarkMode(true);

          expect(repository.darkMode, true);

          await repository.setDarkMode(false);
          expect(repository.darkMode, false);
        },
      );
    },
  );
}
