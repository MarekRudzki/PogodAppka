// Package imports:
import 'package:equatable/equatable.dart';

class DailyWeatherData extends Equatable {
  final int cloudCover;
  final String dateTime;
  final int humidity;
  final String icon;
  final int precip;
  final int precipprob;
  final int pressure;
  final int severerisk;
  final double tempMax;

  const DailyWeatherData({
    required this.cloudCover,
    required this.dateTime,
    required this.humidity,
    required this.icon,
    required this.precip,
    required this.precipprob,
    required this.pressure,
    required this.severerisk,
    required this.tempMax,
  });

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) =>
      DailyWeatherData(
        cloudCover: (json['cloudcover'] as num).round(),
        dateTime: json['datetime'] as String,
        humidity: (json['humidity'] as num).round(),
        icon: json['icon'] as String,
        precip: (json['precip'] as num?)?.round() ?? 0,
        precipprob: (json['precipprob'] as num?)?.round() ?? 0,
        pressure: (json['pressure'] as num).round(),
        severerisk: (json['severerisk'] as num?)?.round() ?? 0,
        tempMax: json['tempmax'] as double,
      );

  @override
  List<Object?> get props => [
        cloudCover,
        dateTime,
        humidity,
        icon,
        precip,
        precipprob,
        pressure,
        severerisk,
        tempMax,
      ];
}
