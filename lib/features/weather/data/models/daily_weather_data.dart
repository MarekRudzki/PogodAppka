import 'package:equatable/equatable.dart';

class DailyWeatherData extends Equatable {
  final double temp;
  final String dateTime;
  final int precip;
  final int precipprob;
  final String icon;
  final int severerisk;

  const DailyWeatherData({
    required this.temp,
    required this.dateTime,
    required this.precip,
    required this.precipprob,
    required this.icon,
    required this.severerisk,
  });

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) =>
      DailyWeatherData(
        temp: json['temp'],
        dateTime: json['datetime'],
        precip: (json['precip'] as num?)?.round() ?? 0,
        precipprob: (json['precipprob'] as num?)?.round() ?? 0,
        icon: json['icon'],
        severerisk: (json['severerisk'] as num?)?.round() ?? 0,
      );

  @override
  List<Object?> get props => [
        temp,
        dateTime,
        precip,
        precipprob,
        icon,
        severerisk,
      ];
}
