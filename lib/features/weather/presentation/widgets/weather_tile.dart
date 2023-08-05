import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  final String hour;
  final String assetName;
  final int temp;
  final int precip;
  final int windDir;
  final int windSpeed;

  const WeatherTile({
    super.key,
    required this.hour,
    required this.assetName,
    required this.precip,
    required this.windDir,
    required this.windSpeed,
    required this.temp,
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
              hour.substring(0, 5),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Image.asset('assets/$assetName.png'),
            Text(
              '$temp ℃',
              style: const TextStyle(
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
              angle: double.parse(windDir.toString()),
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
