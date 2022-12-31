abstract class PreferencesRepository {
  bool get darkMode;

  Future<void> setDarkMode(bool darkMode);
}
