import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/presentation/widgets/day_length.dart';

class SunriseSunset extends StatelessWidget {
  final String sunset;
  final String sunrise;

  const SunriseSunset({
    super.key,
    required this.sunset,
    required this.sunrise,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'Wschód',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 60,
                  child: Image.asset(
                    'assets/sunrise.png',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  sunrise.substring(0, 5),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Zachód',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 60,
                  child: Image.asset(
                    'assets/sunset.png',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  sunset.substring(0, 5),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        DayLength(
          sunset: sunset,
          sunrise: sunrise,
        ),
      ],
    );
  }
}
