import 'package:flutter/material.dart';
import 'package:forms/pages/login/login_mixin.dart';
import 'package:forms/pages/login/widgets/login_checkbox.dart';
import 'package:forms/pages/login/widgets/login_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    bool allowSubmit = emailValidator(_email) == null;

    if (allowSubmit) {
      allowSubmit = passwordValidator(_password) == null;
    }

    return Form(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              LoginTextField(
                label: 'email',
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _email = text.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(height: 30),
              Builder(builder: (context) {
                return LoginTextField(
                  label: 'password',
                  textInputAction: TextInputAction.send,
                  onChanged: (text) {
                    setState(() {
                      _password = text.replaceAll(' ', '');
                    });
                  },
                  obscureText: true,
                  validator: passwordValidator,
                  onSubmitted: (_) => _submit(context),
                );
              }),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              Builder(builder: (context) {
                return MaterialButton(
                  color: Colors.blue.withOpacity(
                    allowSubmit ? 1 : 0.2,
                  ),
                  elevation: 0,
                  onPressed: () => _submit(context),
                  child: const Text(
                    'Sign In',
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final formState = Form.of(context);
    if (formState?.validate() ?? false) {
      print('😅');
    }
  }
}
