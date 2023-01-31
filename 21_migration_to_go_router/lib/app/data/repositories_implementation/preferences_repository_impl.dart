import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/enums.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _preferences;
  final bool _systemDarkMode;

  PreferencesRepositoryImpl(
    this._preferences,
    this._systemDarkMode,
  );

  @override
  bool get darkMode {
    return _preferences.getBool(
          Preference.darkMode.name,
        ) ??
        _systemDarkMode;
  }

  @override
  Future<void> setDarkMode(bool darkMode) {
    return _preferences.setBool(
      Preference.darkMode.name,
      darkMode,
    );
  }
}
