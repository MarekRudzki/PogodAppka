import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/data/models/weather_day_length.dart';

class WeatherData {
  List<DailyWeatherData> dailyWeatherData;

  WeatherData({
    required this.dailyWeatherData,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
      dailyWeatherData: List<DailyWeatherData>.from(
          json['days'].map((e) => DailyWeatherData.fromJson(e))).toList());
}

class DailyWeatherData {
  final WeatherDataHourly weatherDataHourly;
  final WeatherDayLength weatherDayLength;

  DailyWeatherData({
    required this.weatherDataHourly,
    required this.weatherDayLength,
  });

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) {
    return DailyWeatherData(
      weatherDataHourly: WeatherDataHourly(
          hourly:
              List<Hourly>.from(json['hours'].map((e) => Hourly.fromJson(e)))),
      weatherDayLength:
          WeatherDayLength(sunrise: json['sunrise'], sunset: json['sunset']),
    );
  }
}
