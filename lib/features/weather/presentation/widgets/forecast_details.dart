import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/hourly_details.dart';
import 'package:pogodappka/features/weather/presentation/widgets/local_date_time.dart';
import 'package:pogodappka/features/weather/presentation/widgets/sunrise_sunset.dart';
import 'package:worldtime/worldtime.dart';

class ForecastDetails extends StatelessWidget {
  /// Day 0 -> today,
  /// Day 1 -> tommorow
  /// ...
  final int day;
//TODO adjust this widget for tommorow and future days data (to not use localtime)
  const ForecastDetails({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        if (weatherState is WeatherLoading) {
          return Center(
            child: Image.asset(
              'assets/waiting_animation.gif',
              width: 200,
            ),
          );
        } else if (weatherState is WeatherLoaded) {
          final sunrise = weatherState
              .weatherData.weatherDataModel[day].weatherDayLength.sunrise;
          final sunset = weatherState
              .weatherData.weatherDataModel[day].weatherDayLength.sunset;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: BlocBuilder<PlaceCoordinatesBloc, PlaceCoordinatesState>(
              builder: (context, state) {
                if (state is PlaceCoordinatesLoading) {
                  return Center(
                    child: Image.asset(
                      'assets/waiting_animation.gif',
                      width: 200,
                    ),
                  );
                } else if (state is PlaceCoordinatesLoaded) {
                  final worldtimePlugin = Worldtime();
                  return FutureBuilder(
                    future: worldtimePlugin.timeByLocation(
                      latitude: state.placeCooridnatesModel.latitude,
                      longitude: state.placeCooridnatesModel.longitude,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Image.asset(
                            'assets/waiting_animation.gif',
                            width: 200,
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        final DateTime currentLocalTime = snapshot.data!;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        LocalDateTime(
                                          localDateTime: currentLocalTime,
                                          day: day,
                                        ),
                                        const Spacer(),
                                        Text(
                                          showTemperature(
                                            weatherData:
                                                weatherState.weatherData,
                                            day: day,
                                            localTime: currentLocalTime,
                                          ),
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
                                          weatherData: weatherState.weatherData,
                                          day: day,
                                          localDateTime: currentLocalTime,
                                          sunrise: sunrise,
                                          sunset: sunset,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              HourlyDetails(
                                weatherDataHourly: weatherState.weatherData
                                    .weatherDataModel[day].weatherDataHourly,
                              ),
                              SunriseSunset(
                                sunrise: sunrise,
                                sunset: sunset,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Text(
                            'Nie można wyświetlić daty i godziny');
                      }
                    },
                  );
                } else {
                  return const Text('Nie można wyświetlić daty i godziny');
                }
              },
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
  required int day,
  required DateTime localDateTime,
  required String sunrise,
  required String sunset,
}) {
  final double localTimeDouble = localDateTime.hour + localDateTime.minute / 60;
  final double sunriseDouble = double.parse(sunrise.substring(0, 2)) +
      double.parse(sunrise.substring(3, 5)) / 60;
  final double sunsetDouble = double.parse(sunset.substring(0, 2)) +
      double.parse(sunset.substring(3, 5)) / 60;
  final bool isDay =
      localTimeDouble > sunriseDouble && localTimeDouble < sunsetDouble;

  final int severerisk = weatherData.weatherDataModel[day].weatherDataHourly
      .hourly[localDateTime.hour].severerisk;
  final String modelIcon = weatherData
      .weatherDataModel[day].weatherDataHourly.hourly[localDateTime.hour].icon;

  if (severerisk > 30 && isDay) {
    return 'assets/storm.png';
  } else if (severerisk > 30) {
    return 'assets/night-storm.png';
  } else if (modelIcon == 'rain' && !isDay) {
    return 'assets/night-rain.png';
  } else {
    return 'assets/$modelIcon.png';
  }
}

String showTemperature({
  required WeatherData weatherData,
  required int day,
  required DateTime localTime,
}) {
  if (day == 0) {
    final int currentHour = localTime.hour;
    return '${weatherData.weatherDataModel[0].weatherDataHourly.hourly[currentHour].temp} ℃';
  } else {
    return 'zara opracuje ℃';
  }
}
