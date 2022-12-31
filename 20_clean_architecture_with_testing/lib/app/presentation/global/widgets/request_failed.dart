import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/translations.g.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({
    super.key,
    required this.onRetry,
    this.text,
  });

  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Assets.svgs.error404.svg(),
          ),
          Text(text ?? texts.misc.requestFailed),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blue,
            child: Text(texts.misc.retry),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
