import 'package:inherited_widgets/state_management/notifier.dart';

class ThemeController extends ProviderNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    notify();
  }
}
