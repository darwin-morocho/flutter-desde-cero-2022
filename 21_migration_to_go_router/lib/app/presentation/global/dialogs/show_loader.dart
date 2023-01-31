import 'package:flutter/material.dart';

Future<T> showLoader<T>(
  BuildContext context,
  Future<T> future,
) async {
  final overlayState = Overlay.of(context)!;
  final entry = OverlayEntry(
    builder: (_) => const ProgressDialog(),
  );
  overlayState.insert(entry);

  final result = await future;
  entry.remove();
  return result;
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
