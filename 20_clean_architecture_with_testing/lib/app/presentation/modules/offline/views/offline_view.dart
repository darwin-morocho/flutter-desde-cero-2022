import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../inject_repositories.dart';
import '../../../routes/routes.dart';

class OfflineView extends StatefulWidget {
  const OfflineView({super.key});

  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  void _init() {
    _subscription = Repositories.connectivity.onInternetChanged.listen(
      (connected) {
        if (connected) {
          Navigator.pushReplacementNamed(
            context,
            Routes.splash,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('OFFLINE'),
      ),
    );
  }
}
