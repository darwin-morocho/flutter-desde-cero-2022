import 'package:flutter/material.dart';

import '../../../../../../domain/enums.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../global/colors.dart';
import '../../../../../global/extensions/build_context_ext.dart';

class TrendingTimeWindow extends StatelessWidget {
  const TrendingTimeWindow({
    super.key,
    required this.timeWindow,
    required this.onChanged,
  });
  final TimeWindow timeWindow;
  final void Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            texts.home.trending,
            style: context.textTheme.titleSmall,
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color:
                  context.darkMode ? AppColors.dark : const Color(0xfff0f0f0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<TimeWindow>(
                  key: const Key('dropdown-time-window'),
                  value: timeWindow,
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: TimeWindow.day,
                      child: Text(
                        texts.home.dropdownButton.last24,
                      ),
                    ),
                    DropdownMenuItem(
                      value: TimeWindow.week,
                      child: Text(
                        texts.home.dropdownButton.lastWeek,
                      ),
                    ),
                  ],
                  onChanged: (mTimeWindow) {
                    if (mTimeWindow != null && timeWindow != mTimeWindow) {
                      onChanged(mTimeWindow);
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
