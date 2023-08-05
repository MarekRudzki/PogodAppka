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
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  @override
  List<Object?> get props => [
        sunrise,
        sunset,
      ];
}
