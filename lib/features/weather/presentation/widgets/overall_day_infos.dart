// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/widgets/digital_clock.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

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
        '${toBeginningOfSentenceCase(DateFormat('EEEE', context.l10n.dateTypeLanguage).format(
      day == 0
          ? localDateTime
          : localDateTime.add(
              Duration(days: day),
            ),
    ))!}, ${toBeginningOfSentenceCase(DateFormat('d MMMM', context.l10n.dateTypeLanguage).format(
      day == 0
          ? localDateTime
          : localDateTime.add(
              Duration(days: day),
            ),
    ))!}';

    return Column(
      children: [
        if (day < 2)
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                dateFormatted,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        if (day == 0)
          Column(
            children: [
              const SizedBox(height: 10),
              DigitalClock(
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
              ),
            ],
          ),
        if (day < 2) const SizedBox(height: 20),
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
        if (day == 0)
          const SizedBox(height: 20)
        else
          const SizedBox(height: 35),
        Text(
          '${context.l10n.cloudCover}: ${dailyData.cloudCover}%',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          '${context.l10n.humidity}: ${dailyData.humidity}%',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          '${context.l10n.pressure}: ${dailyData.pressure} hPa',
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
