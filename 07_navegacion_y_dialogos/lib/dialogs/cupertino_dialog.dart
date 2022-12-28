import 'package:flutter/cupertino.dart';

Future<int> showDialogWithCupertinoStyle(
  BuildContext context, {
  String title = '',
  String content = '',
}) async {
  final result = await showCupertinoDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          child: const Text("ok"),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context, 2);
          },
          child: const Text("I'm bad"),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context, 3);
          },
          child: const Text("so so"),
        ),
      ],
    ),
  );

  return result ?? 1;
}
