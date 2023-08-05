import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/day_description.dart';
import 'package:pogodappka/features/weather/presentation/widgets/sunrise_sunset.dart';
import 'package:pogodappka/features/weather/presentation/widgets/weather_tile.dart';

class ForecastDetails extends StatelessWidget {
  const ForecastDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (weatherState is WeatherLoaded) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        const Column(
                          children: [
                            DayDescription(),
                            Spacer(),
                            Text(
                              '22 ℃',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Expanded(
                          child: Image.asset(
                            buildWeatherIcon(
                              weatherData: weatherState.weatherData,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 300,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: const Row(
                        children: [
                          WeatherTile(
                            hour: '11:00',
                            assetName: 'assets/clear-day.png',
                            precip: 3,
                            windDir: 223,
                            windSpeed: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SunriseSunset(
                    sunrise: weatherState.weatherData.dailyWeatherData[0]
                        .weatherDayLength.sunrise,
                    sunset: weatherState.weatherData.dailyWeatherData[0]
                        .weatherDayLength.sunset,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Błąd! Coś poszło nie tak');
        }
      },
    );
  }
}

String buildWeatherIcon({
  required WeatherData weatherData,
}) {
  return 'assets/${weatherData.dailyWeatherData[0].weatherDataHourly.hourly[13].icon}.png';
  // if (weatherData.severerisk > 30) {
  //   return 'assets/storm.png'; //TODO
  // } else {
  //   return 'assets/${weatherData.iconName}.png';
  // }
}
