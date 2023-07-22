import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final String hour;
  final String assetName;
  final double precip;
  final double windDir;
  final double windSpeed;

  const WeatherTile({
    super.key,
    required this.hour,
    required this.assetName,
    required this.precip,
    required this.windDir,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hour,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Image.asset(assetName),
            const Text(
              '25 ℃',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 7),
            Image.asset(
              'assets/precip.png',
              scale: 10,
            ),
            Text(
              '$precip mm',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 7),
            Transform.rotate(
              angle: windDir,
              child: Image.asset(
                'assets/wind-arrow.png',
                scale: 13,
              ),
            ),
            Text(
              '$windSpeed km/h',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
