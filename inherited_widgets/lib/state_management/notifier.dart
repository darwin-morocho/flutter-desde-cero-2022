import 'package:flutter/foundation.dart';

typedef VoidCallback = void Function();

abstract class ProviderNotifier {
  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  @protected
  void notify() {
    for (final listener in _listeners) {
      listener();
    }
  }

  @protected
  @mustCallSuper
  void dispose() {
    _listeners.clear();
  }
}
