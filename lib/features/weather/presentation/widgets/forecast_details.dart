import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/hourly_details.dart';
import 'package:pogodappka/features/weather/presentation/widgets/overall_day_infos.dart';
import 'package:pogodappka/features/weather/presentation/widgets/sunrise_sunset.dart';
import 'package:worldtime/worldtime.dart';

class ForecastDetails extends StatelessWidget {
  /// Day 0 -> today,
  /// Day 1 -> tommorow
  /// ...
  final int day;
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OverallDayInfos(
                                    localDateTime: currentLocalTime,
                                    day: day,
                                    weatherData: weatherState.weatherData,
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
                              HourlyDetails(
                                weatherDataHourly: weatherState.weatherData
                                    .weatherDataModel[day].weatherDataHourly,
                                sunrise: sunrise,
                                sunset: sunset,
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
  final bool isDay = day == 0
      ? localTimeDouble > sunriseDouble && localTimeDouble < sunsetDouble
      : true;

  final int severerisk = day == 0
      ? weatherData.weatherDataModel[0].weatherDataHourly
          .hourly[localDateTime.hour].severerisk
      : weatherData.weatherDataModel[day].dailyWeatherData.severerisk;

  final String modelIcon = day == 0
      ? localDateTime.minute < 30
          ? weatherData.weatherDataModel[day].weatherDataHourly
              .hourly[localDateTime.hour].icon
          : weatherData.weatherDataModel[day].weatherDataHourly
              .hourly[localDateTime.hour + 1].icon
      : weatherData.weatherDataModel[day].dailyWeatherData.icon;

  if (severerisk > 30 && (isDay || day != 0)) {
    return 'assets/storm.png';
  } else if (severerisk > 30) {
    return 'assets/night-storm.png';
  } else if (modelIcon == 'rain' && !isDay) {
    return 'assets/night-rain.png';
  } else {
    return 'assets/$modelIcon.png';
  }
}
