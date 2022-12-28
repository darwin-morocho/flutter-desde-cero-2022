import 'package:flutter/material.dart';
import 'package:inherited_widgets/state_management/consumer.dart';

import '../pages/my_home_page.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 200,
        ),
        child: Consumer<MyHomePageController>(
          builder: (_, controller) => Text(
            controller.counter.toString(),
            key: UniqueKey(),
            style: const TextStyle(
              fontSize: 45,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
