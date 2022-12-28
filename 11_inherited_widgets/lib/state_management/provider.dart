import 'package:flutter/material.dart';

import 'notifier.dart';

class Provider<T extends ProviderNotifier> extends StatefulWidget {
  const Provider({
    Key? key,
    required this.child,
    required this.create,
  }) : super(key: key);
  final Widget child;
  final T Function() create;

  @override
  State<Provider<T>> createState() => _ProviderState<T>();

  static T of<T extends ProviderNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_InheritedWidget<T>>();

    assert(provider != null);

    return provider!.notifier;
  }
}

class _ProviderState<T extends ProviderNotifier> extends State<Provider<T>> {
  late final T _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = widget.create();
  }

  @override
  void dispose() {
    // ignore: invalid_use_of_protected_member
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      notifier: _notifier,
      child: widget.child,
    );
  }
}

class _InheritedWidget<T extends ProviderNotifier> extends InheritedWidget {
  final T notifier;
  const _InheritedWidget({
    Key? key,
    required this.notifier,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(_) {
    return false;
  }
}
