import 'package:pogodappka/features/weather/data/models/daily_weather_data.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/data/models/weather_day_length.dart';

class WeatherData {
  List<WeatherDataModel> weatherDataModel;

  WeatherData({
    required this.weatherDataModel,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
      weatherDataModel: List<WeatherDataModel>.from(
          json['days'].map((e) => WeatherDataModel.fromJson(e))).toList());
}

class WeatherDataModel {
  final WeatherDataHourly weatherDataHourly;
  final WeatherDayLength weatherDayLength;
  final DailyWeatherData dailyWeatherData;

  WeatherDataModel({
    required this.weatherDataHourly,
    required this.weatherDayLength,
    required this.dailyWeatherData,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      weatherDataHourly: WeatherDataHourly.fromJson(json),
      weatherDayLength: WeatherDayLength.fromJson(json),
      dailyWeatherData: DailyWeatherData.fromJson(json),
    );
  }
}
