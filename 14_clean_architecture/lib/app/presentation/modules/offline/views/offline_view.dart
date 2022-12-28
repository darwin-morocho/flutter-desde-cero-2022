import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/connectivity_repository.dart';
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

    _subscription =
        context.read<ConnectivityRepository>().onInternetChanged.listen(
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
