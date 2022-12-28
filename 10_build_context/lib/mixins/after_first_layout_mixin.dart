import 'dart:async';

import 'package:flutter/widgets.dart'
    show State, StatefulWidget, WidgetsBinding;

mixin AfterFirstLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        onAfterFirstLayout();
      },
    );
  }

  FutureOr<void> onAfterFirstLayout();
}
