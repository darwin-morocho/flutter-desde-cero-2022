import 'package:flutter/material.dart';
import 'package:navigation/dialogs/bottom_sheet_dialog.dart';
import 'package:navigation/dialogs/confirm_dialog.dart';
import 'package:navigation/dialogs/cupertino_dialog.dart';
import 'package:navigation/dialogs/custom_dialog.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("show info dialog"),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => const DialogContent(),
              );
              print("😅");
            },
          ),
          ListTile(
            title: const Text("show confirm dialog"),
            onTap: () async {
              final isOk = await showConfirmDialog(
                context,
                title: 'Are you sure?',
                dismissble: false,
              );
              print("is ok $isOk");
            },
          ),
          ListTile(
            title: const Text("show cupertinoDialog dialog"),
            onTap: () async {
              final value = await showDialogWithCupertinoStyle(
                context,
                title: 'Hi',
                content: 'How are you?',
              );
              print("value $value");
            },
          ),
          ListTile(
            title: const Text("show bottom sheet dialog"),
            onTap: () async {
              showBottomSheetDialog(context);
            },
          ),
          ListTile(
            title: const Text("show custom dialog"),
            onTap: () {
              showCustomDialog(context);
            },
          )
        ],
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("My dialog jaja"),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK ->"),
        ),
      ],
    );
  }
}
