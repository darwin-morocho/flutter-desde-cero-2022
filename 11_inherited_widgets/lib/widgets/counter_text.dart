import 'package:flutter/material.dart';
import 'package:inherited_widgets/pages/my_home_page.dart';
import 'package:inherited_widgets/state_management/consumer.dart';
import 'package:inherited_widgets/widgets/animated_text.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyHomePageController>(
      builder: (_, controller) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: controller.color,
          shape: BoxShape.circle,
        ),
        child: const AnimatedText(),
      ),
    );
  }
}
