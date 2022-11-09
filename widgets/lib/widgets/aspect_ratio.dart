import 'package:flutter/material.dart';

class MyAspectRatio extends StatelessWidget {
  const MyAspectRatio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            'https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2019/10/goku-dbz-style-by-mangasalivehd-dcy4chb-pre.jpg?fit=1080%2C607&quality=80&ssl=1',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
