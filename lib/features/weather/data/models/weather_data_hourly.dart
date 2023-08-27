// Package imports:
import 'package:equatable/equatable.dart';

class WeatherDataHourly extends Equatable {
  final List<Hourly> hourly;

  WeatherDataHourly({
    required this.hourly,
  });

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
        hourly: List<Hourly>.from((json['hours'] as List<dynamic>)
            .map((e) => Hourly.fromJson(e as Map<String, dynamic>))),
      );

  @override
  List<Object?> get props => [
        hourly,
      ];
}

class Hourly extends Equatable {
  final String datetime;
  final String icon;
  final int precip;
  final int precipprob;
  final int severerisk;
  final double temp;
  final int winddir;
  final int windspeed;

  const Hourly({
    required this.datetime,
    required this.icon,
    required this.precip,
    required this.precipprob,
    required this.severerisk,
    required this.temp,
    required this.winddir,
    required this.windspeed,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        datetime: json['datetime'] as String,
        icon: json['icon'] as String,
        precip: (json['precip'] as num?)?.round() ?? 0,
        precipprob: (json['precipprob'] as num?)?.round() ?? 0,
        severerisk: (json['severerisk'] as num?)?.round() ?? 0,
        temp: json['temp'] as double,
        winddir: (json['winddir'] as num?)?.round() ?? 0,
        windspeed: (json['windspeed'] as num?)?.round() ?? 0,
      );

  @override
  List<Object?> get props => [
        datetime,
        icon,
        precip,
        precipprob,
        severerisk,
        temp,
        winddir,
        windspeed,
      ];
}
