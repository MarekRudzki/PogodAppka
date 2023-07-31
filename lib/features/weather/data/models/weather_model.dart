import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel(
    this.cloudCover,
    this.sunrise,
    this.sunset,
    this.currentTemperature,
    this.humidity,
    this.pressure,
    this.iconName,
    this.precip,
    this.winddir,
    this.windspeed,
    this.severerisk,
  );

  final double currentTemperature;
  final double cloudCover;
  final double humidity;
  final double pressure;
  final String sunrise;
  final String sunset;
  final String iconName;
  final double precip;
  final double winddir;
  final double windspeed;
  final double severerisk;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : currentTemperature = json['currentConditions']['temp'],
        cloudCover = json['currentConditions']['cloudcover'],
        humidity = json['currentConditions']['humidity'],
        pressure = json['currentConditions']['pressure'],
        sunrise = json['currentConditions']['sunrise'],
        sunset = json['currentConditions']['sunset'],
        iconName = json['currentConditions']['icon'],
        precip = json['currentConditions']['precip'] ?? 0.0,
        winddir = json['currentConditions']['winddir'] ?? 0.0,
        windspeed = json['currentConditions']['windspeed'] ?? 0.0,
        severerisk = json['currentConditions']['severerisk'] ?? 0.0;

  @override
  List<Object?> get props => [
        currentTemperature,
        cloudCover,
        humidity,
        pressure,
        sunrise,
        sunset,
        iconName,
        precip,
        winddir,
        windspeed,
      ];
}
