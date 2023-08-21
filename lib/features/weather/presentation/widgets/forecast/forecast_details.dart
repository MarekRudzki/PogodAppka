// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldtime/worldtime.dart';

// Project imports:
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/hourly_details.dart';
import 'package:pogodappka/features/weather/presentation/widgets/overall_day_infos.dart';
import 'package:pogodappka/features/weather/presentation/widgets/sunrise_sunset.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

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
              'assets/waiting-animation.gif',
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
                      'assets/waiting-animation.gif',
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
                            'assets/waiting-animation.gif',
                            width: 200,
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        final DateTime currentLocalTime = snapshot.data!;

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OverallDayInfos(
                                      localDateTime: currentLocalTime,
                                      day: day,
                                      weatherData: weatherState.weatherData,
                                    ),
                                  ),
                                  Image.asset(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    showWeatherIcon(
                                      weatherData: weatherState.weatherData,
                                      day: day,
                                      localDateTime: currentLocalTime,
                                      sunrise: sunrise,
                                      sunset: sunset,
                                    ),
                                  ),
                                ],
                              ),
                              HourlyDetails(
                                weatherDataHourly: weatherState.weatherData
                                    .weatherDataModel[day].weatherDataHourly,
                                day: day,
                                localDateTime: currentLocalTime,
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
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                context.l10n.errorCitySearch,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }
}

String showWeatherIcon({
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
  final bool isDay;
  if (day == 0) {
    isDay = localTimeDouble > sunriseDouble && localTimeDouble < sunsetDouble;
  } else {
    isDay = true;
  }

  final int severerisk = day == 0
      ? weatherData.weatherDataModel[0].weatherDataHourly
          .hourly[localDateTime.hour].severerisk
      : weatherData.weatherDataModel[day].dailyWeatherData.severerisk;

  // Daily data about icons from API service is not always correctly
  // so the following function has to been done
  String showIcon() {
    final int sunriseHour = int.parse(sunrise.substring(0, 2)) + 1;
    final int sunsetHour = int.parse(sunset.substring(0, 2));
    final List<String> dayIcons = [];

    for (int i = sunriseHour; i < sunsetHour; i++) {
      dayIcons.add(
          weatherData.weatherDataModel[day].weatherDataHourly.hourly[i].icon);
    }

    // Create map of all values and count it
    final Map<String, int> folded = dayIcons.fold({}, (acc, curr) {
      acc[curr] = (acc[curr] ?? 0) + 1;
      return acc;
    });

    // Get maximum value inside map
    final sortedKeys = folded.keys.toList()
      ..sort((a, b) => folded[b]!.compareTo(folded[a]!));

    return sortedKeys.first;
  }

  String getModelIcon() {
    if (day != 0) {
      return showIcon();
    } else if (localDateTime.minute < 30 || localDateTime.hour == 23) {
      return weatherData.weatherDataModel[day].weatherDataHourly
          .hourly[localDateTime.hour].icon;
    } else {
      return weatherData.weatherDataModel[day].weatherDataHourly
          .hourly[localDateTime.hour + 1].icon;
    }
  }

  if (severerisk > 30 && (isDay || day != 0)) {
    return 'assets/storm.png';
  } else if (severerisk > 30) {
    return 'assets/night-storm.png';
  } else if (getModelIcon() == 'rain' && !isDay) {
    return 'assets/night-rain.png';
  } else {
    return 'assets/${getModelIcon()}.png';
  }
}
