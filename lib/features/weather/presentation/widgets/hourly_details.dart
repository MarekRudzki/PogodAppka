import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/presentation/widgets/weather_tile.dart';

class HourlyDetails extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  final String sunrise;
  final String sunset;

  const HourlyDetails({
    super.key,
    required this.weatherDataHourly,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: weatherDataHourly.hourly.length,
              itemBuilder: (context, index) => WeatherTile(
                hourlyData: weatherDataHourly.hourly[index],
                sunrise: sunrise,
                sunset: sunset,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
