import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../global/controllers/theme_controller.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../routes/routes.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: context.darkMode,
                onChanged: (value) {
                  context.read<ThemeController>().onChanged(value);
                },
              ),
              if (sessionController.state != null)
                ListTile(
                  key: const Key('sign-out-list-tile'),
                  onTap: () async {
                    await sessionController.signOut();
                    if (mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.signIn,
                        (_) => false,
                      );
                    }
                  },
                  title: const Text('Sign out'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
