import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayDescription extends StatelessWidget {
  final DateTime date;
  const DayDescription({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          toBeginningOfSentenceCase(
              DateFormat('d MMMM yyyy', 'pl').format(date).toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          toBeginningOfSentenceCase(
              DateFormat('EEEE', 'pl').format(date).toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        )
      ],
    );
  }
}
