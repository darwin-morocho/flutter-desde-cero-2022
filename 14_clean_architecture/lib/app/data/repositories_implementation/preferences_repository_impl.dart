import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/enums.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _preferences;

  PreferencesRepositoryImpl(this._preferences);

  @override
  bool? get darkMode {
    return _preferences.getBool(
      Preference.darkMode.name,
    );
  }

  @override
  Future<void> setDarkMode(bool darkMode) {
    return _preferences.setBool(
      Preference.darkMode.name,
      darkMode,
    );
  }
}
