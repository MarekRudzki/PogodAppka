import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pogodappka/features/weather/presentation/widgets/digital_clock.dart';

class LocalDateTime extends StatelessWidget {
  final DateTime localDateTime;
  final int day;

  const LocalDateTime({
    super.key,
    required this.localDateTime,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          toBeginningOfSentenceCase(DateFormat('d MMMM yyyy', 'pl')
              .format(localDateTime)
              .toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          toBeginningOfSentenceCase(
              DateFormat('EEEE', 'pl').format(localDateTime).toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 7),
        day == 0
            ? DigitalClock(
                hourMinuteDigitTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                colonTimerInMiliseconds: 1000,
                dateTime: localDateTime,
                showSecondsDigit: false,
                colon: const Text(
                  ":",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
