import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fifteen_day_forecast/fifteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/forecast_details.dart';

class FifteenDayForecast extends StatelessWidget {
  const FifteenDayForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FifteenDayForecastBloc, FifteenDayForecastState>(
      builder: (context, state) {
        if (state is FifteenDayForecastLoading) {
          return Center(
            child: Image.asset(
              'assets/waiting-animation.gif',
              width: 200,
            ),
          );
        }
        if (state is FifteenDayForecastLoaded) {
          return SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                context.read<FifteenDayForecastBloc>().add(
                      ExpandTile(
                        tileIndex: index,
                        isExpanded: isExpanded,
                        weatherData: state.weatherData,
                      ),
                    );
              },
              animationDuration: const Duration(seconds: 2),
              children: [
                for (int day = 2; day < 15; day++)
                  ExpansionPanel(
                    backgroundColor: const Color.fromARGB(255, 54, 202, 184),
                    isExpanded: state.isExpanded[day],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toBeginningOfSentenceCase(
                                  DateFormat('EEEE', 'pl').format(
                                      DateTime.parse(state
                                          .weatherData
                                          .weatherDataModel[day]
                                          .dailyWeatherData
                                          .dateTime)),
                                ).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                  DateFormat('d MMMM', 'pl').format(
                                      DateTime.parse(state
                                          .weatherData
                                          .weatherDataModel[day]
                                          .dailyWeatherData
                                          .dateTime)),
                                ).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${state.weatherData.weatherDataModel[day].dailyWeatherData.tempMax} ℃',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Image.asset(
                            showWeatherIcon(
                              weatherData: state.weatherData,
                              day: day,
                            ),
                            scale: 8.5,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    body: Visibility(
                      visible: state.isExpanded[day],
                      child: AnimatedOpacity(
                        opacity: state.isExpanded[day] ? 1 : 0,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(seconds: 2),
                        child: ForecastDetails(day: day),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const Text('Nie można załadować pogody');
        }
      },
    );
  }
}

String showWeatherIcon({
  required WeatherData weatherData,
  required int day,
}) {
  final int severerisk =
      weatherData.weatherDataModel[day].dailyWeatherData.severerisk;
  final icon = weatherData.weatherDataModel[day].dailyWeatherData.icon;
  final sunrise = weatherData.weatherDataModel[day].weatherDayLength.sunrise;
  final sunset = weatherData.weatherDataModel[day].weatherDayLength.sunset;

  // Daily data about icons from API service is not always correctly
  // so the following function has to been done
  String replaceRainIcon() {
    final int sunriseHour = int.parse(sunrise.substring(0, 2)) + 1;
    final int sunsetHour = int.parse(sunset.substring(0, 2));
    final List<String> dayIcons = [];

    for (int i = sunriseHour; i < sunsetHour; i++) {
      dayIcons.add(
          weatherData.weatherDataModel[day].weatherDataHourly.hourly[i].icon);
    }

    // Create map of all values and count it
    final folded = dayIcons.fold({}, (acc, curr) {
      acc[curr] = (acc[curr] ?? 0) + 1;
      return acc;
    });

    // Get maximum value inside map
    final sortedKeys = folded.keys.toList()
      ..sort((a, b) => folded[b].compareTo(folded[a]));
    return '${sortedKeys.first}';
  }

  if (severerisk > 30) {
    return 'assets/storm.png';
  } else if (icon == 'rain') {
    return 'assets/${replaceRainIcon()}.png';
  } else {
    return 'assets/$icon.png';
  }
}
