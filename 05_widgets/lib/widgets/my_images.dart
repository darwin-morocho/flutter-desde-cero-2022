import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          width: 350,
          height: 500,
          child: CachedNetworkImage(
            imageUrl: "https://www.seekpng.com/png/detail/320-3202429_dragon-ball-z-characters-png.png",
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (_, __, ___) => const Icon(
              Icons.error,
            ),
          ),
        ),
      ),
    );
  }
}
