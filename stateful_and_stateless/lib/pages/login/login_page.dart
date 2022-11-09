import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '', _password = '';

  bool get _isValidEmail {
    return _email.contains("@");
  }

  bool get _isValidPassword {
    return _password.replaceAll(' ', '').length >= 5;
  }

  @override
  Widget build(BuildContext context) {
    // bool isValid = false;
    // if (_email.contains("@") && _password.replaceAll(' ', '').length >= 5) {
    //   isValid = true;
    // }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("email:"),
              TextField(
                onChanged: (text) {
                  _email = text;
                  setState(() {});
                },
              ),
              const SizedBox(height: 30),
              const Text("password:"),
              TextField(
                onChanged: (text) {
                  _password = text;
                  setState(() {});
                },
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: _isValidEmail && _isValidPassword ? () {} : null,
                child: const Text("SEND"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
