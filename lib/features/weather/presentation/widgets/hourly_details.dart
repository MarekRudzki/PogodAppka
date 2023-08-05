import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/presentation/widgets/weather_tile.dart';

class HourlyDetails extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDetails({
    super.key,
    required this.weatherDataHourly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherDataHourly.hourly.length,
                  itemBuilder: (context, index) => WeatherTile(
                    hour: weatherDataHourly.hourly[index].datetime,
                    assetName: weatherDataHourly.hourly[index].icon,
                    temp: weatherDataHourly.hourly[index].temp.round(),
                    precip: weatherDataHourly.hourly[index].precip,
                    windDir: weatherDataHourly.hourly[index].winddir,
                    windSpeed: weatherDataHourly.hourly[index].windspeed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
