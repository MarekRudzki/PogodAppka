// Package imports:
import 'package:equatable/equatable.dart';

class WeatherDayLength extends Equatable {
  final String sunrise;
  final String sunset;

  const WeatherDayLength({
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherDayLength.fromJson(Map<String, dynamic> json) =>
      WeatherDayLength(
        sunrise: json['sunrise'] as String,
        sunset: json['sunset'] as String,
      );

  @override
  List<Object?> get props => [
        sunrise,
        sunset,
      ];
}
