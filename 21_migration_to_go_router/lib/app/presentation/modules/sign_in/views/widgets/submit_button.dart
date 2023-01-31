import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/translations.g.dart';
import '../../../../routes/routes.dart';
import '../../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    }

    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context)!.validate();
        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: Text(texts.signIn.signIn),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }

    result.when(
      left: (failure) {
        final message = failure.when(
          notFound: () => texts.signIn.errors.submit.notFound,
          network: () => texts.signIn.errors.submit.network,
          unauthorized: () => texts.signIn.errors.submit.unauthorized,
          unknown: () => texts.signIn.errors.submit.unknown,
          notVerified: () => texts.signIn.errors.submit.notVerified,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      right: (_) => context.goNamed(
        Routes.home,
      ),
    );
  }
}
