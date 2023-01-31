import 'package:flutter/foundation.dart';

import '../../../domain/repositories/preferences_repository.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(
    this._darkMode, {
    required this.preferencesRepository,
  });

  final PreferencesRepository preferencesRepository;
  bool _darkMode;
  bool get darkMode => _darkMode;

  Future<void> onChanged(bool darkMode) async {
    _darkMode = darkMode;
    await preferencesRepository.setDarkMode(_darkMode);
    notifyListeners();
  }
}
