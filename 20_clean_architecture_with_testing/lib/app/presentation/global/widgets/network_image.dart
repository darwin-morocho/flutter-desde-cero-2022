import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    super.key,
    required this.url,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.fit,
  });
  final String url;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (Platform.environment.keys.contains('FLUTTER_TEST')) {
      return const SizedBox();
    }
    // coverage:ignore-start
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      semanticLabel: semanticLabel,
      color: color,
      fit: fit,
      opacity: opacity,
      excludeFromSemantics: excludeFromSemantics,
    );
    // coverage:ignore-end
  }
}
