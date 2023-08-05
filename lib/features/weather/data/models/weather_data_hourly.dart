import 'package:equatable/equatable.dart';

class WeatherDataHourly {
  List<Hourly> hourly;

  WeatherDataHourly({
    required this.hourly,
  });

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
        hourly: List<Hourly>.from(json['hours'].map((e) => Hourly.fromJson(e))),
      );
}

class Hourly extends Equatable {
  final String datetime;
  final double temp;
  final int cloudCover;
  final int humidity;
  final int pressure;
  final String icon;
  final int precip;
  final int winddir;
  final int windspeed;
  final int severerisk;
  final int precipprob;

  const Hourly({
    required this.datetime,
    required this.temp,
    required this.cloudCover,
    required this.humidity,
    required this.pressure,
    required this.icon,
    required this.precip,
    required this.precipprob,
    required this.winddir,
    required this.windspeed,
    required this.severerisk,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        datetime: json['datetime'],
        temp: json['temp'],
        cloudCover: (json['cloudcover'] as num).round(),
        humidity: (json['humidity'] as num).round(),
        pressure: (json['pressure'] as num).round(),
        icon: json['icon'],
        precip: (json['precip'] as num?)?.round() ?? 0,
        precipprob: (json['precipprob'] as num?)?.round() ?? 0,
        winddir: (json['winddir'] as num?)?.round() ?? 0,
        windspeed: (json['windspeed'] as num?)?.round() ?? 0,
        severerisk: (json['severerisk'] as num?)?.round() ?? 0,
      );

  @override
  List<Object?> get props => [
        datetime,
        temp,
        cloudCover,
        humidity,
        pressure,
        precipprob,
        icon,
        precip,
        winddir,
        windspeed,
        severerisk,
      ];
}
