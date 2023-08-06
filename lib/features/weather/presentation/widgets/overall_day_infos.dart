import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

import 'package:pogodappka/features/weather/presentation/widgets/digital_clock.dart';

class OverallDayInfos extends StatelessWidget {
  final DateTime localDateTime;
  final int day;
  final WeatherData weatherData;

  const OverallDayInfos({
    super.key,
    required this.localDateTime,
    required this.day,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final dailyData = weatherData.weatherDataModel[day].dailyWeatherData;
    final String dateFormatted =
        '${toBeginningOfSentenceCase(DateFormat('EEEE', 'pl').format(
              day == 0
                  ? localDateTime
                  : localDateTime.add(
                      Duration(days: day),
                    ),
            ).toString())!}, ${toBeginningOfSentenceCase(DateFormat('d MMMM', 'pl').format(
              day == 0
                  ? localDateTime
                  : localDateTime.add(
                      Duration(days: day),
                    ),
            ).toString())!}';

    return Column(
      children: [
        Text(
          dateFormatted,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        day == 0
            ? DigitalClock(
                hourMinuteDigitTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                colonTimerInMiliseconds: 1000,
                dateTime: localDateTime,
                showSecondsDigit: false,
                colon: const Text(
                  ":",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            : const SizedBox(height: 15),
        const SizedBox(height: 20),
        Text(
          showTemperature(
            weatherData: weatherData,
            day: day,
            localTime: localDateTime,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        day == 0 ? const SizedBox(height: 20) : const SizedBox(height: 35),
        Text(
          'Zachmurzenie: ${dailyData.cloudCover}%',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Wilgotość: ${dailyData.humidity}%',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Ciśnienie: ${dailyData.pressure} hPa',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
      ],
    );
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
    return '${weatherData.weatherDataModel[day].dailyWeatherData.tempMax} ℃';
  }
}
