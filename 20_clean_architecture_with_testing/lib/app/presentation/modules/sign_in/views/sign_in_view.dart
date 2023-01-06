import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/translations.g.dart';
import '../../../../inject_repositories.dart';
import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
        sessionController: context.read(),
        favoritesController: context.read(),
        authenticationRepository: Repositories.authentication,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final controller = Provider.of<SignInController>(
                    context,
                    listen: true,
                  );
                  return AbsorbPointer(
                    absorbing: controller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          key: const Key('input-username'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) {
                            controller.onUsernameChanged(text);
                          },
                          decoration: InputDecoration(
                            hintText: texts.signIn.username,
                          ),
                          validator: (text) {
                            text = text?.trim().toLowerCase() ?? '';
                            if (text.isEmpty) {
                              return texts.signIn.errors.username;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const Key('input-password'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) {
                            controller.onPasswordChanged(text);
                          },
                          decoration: InputDecoration(
                            hintText: texts.signIn.password,
                          ),
                          validator: (text) {
                            text = text?.replaceAll(' ', '') ?? '';
                            if (text.length < 4) {
                              return texts.signIn.errors.password;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
