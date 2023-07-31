import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_model.dart';

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
                        Column(
                          children: [
                            const DayDescription(),
                            const Spacer(),
                            Text(
                              '${weatherState.weatherModel.currentTemperature.toString()} ℃',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Expanded(
                          child: Image.asset(
                            buildWeatherIcon(
                              weatherModel: weatherState.weatherModel,
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
                      child: Row(
                        children: [
                          WeatherTile(
                            hour: '11:00',
                            assetName: 'assets/clear-day.png',
                            precip: weatherState.weatherModel.precip,
                            windDir: weatherState.weatherModel.winddir,
                            windSpeed: weatherState.weatherModel.windspeed,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SunriseSunset(
                    sunrise: weatherState.weatherModel.sunrise,
                    sunset: weatherState.weatherModel.sunset,
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
  required WeatherModel weatherModel,
}) {
  if (weatherModel.severerisk > 30) {
    return 'assets/storm.png'; //TODO
  } else {
    return 'assets/${weatherModel.iconName}.png';
  }
}
