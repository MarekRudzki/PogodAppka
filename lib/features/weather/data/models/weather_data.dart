// Project imports:
import 'package:pogodappka/features/weather/data/models/daily_weather_data.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/data/models/weather_day_length.dart';

class WeatherData {
  List<WeatherDataModel> weatherDataModel;

  WeatherData({
    required this.weatherDataModel,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
      weatherDataModel: List<WeatherDataModel>.from((json['days']
                  as List<dynamic>)
              .map((e) => WeatherDataModel.fromJson(e as Map<String, dynamic>)))
          .toList());
}

class WeatherDataModel {
  final DailyWeatherData dailyWeatherData;
  final WeatherDataHourly weatherDataHourly;
  final WeatherDayLength weatherDayLength;

  WeatherDataModel({
    required this.dailyWeatherData,
    required this.weatherDataHourly,
    required this.weatherDayLength,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      dailyWeatherData: DailyWeatherData.fromJson(json),
      weatherDataHourly: WeatherDataHourly.fromJson(json),
      weatherDayLength: WeatherDayLength.fromJson(json),
    );
  }
}
