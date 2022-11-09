import 'package:flutter/material.dart';
import 'package:navigation/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            // Navigator.popUntil(
            //   context,
            //   (route) {
            //     final name = route.settings.name;
            //     return name == Routes.initialRoute;
            //   },
            // );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.initialRoute,
              (route) => false,
            );
          },
          child: Text("LOG OUT"),
        ),
      ),
    );
  }
}
