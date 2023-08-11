import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';

class WeatherTile extends StatelessWidget {
  final Hourly hourlyData;
  final String sunrise;
  final String sunset;

  /// 0 -> temp, 1 -> precip, 2 -> wind
  final int index;

  const WeatherTile({
    super.key,
    required this.hourlyData,
    required this.sunrise,
    required this.sunset,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 60,
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                hourlyData.datetime.substring(0, 5),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              index == 0
                  ? Column(
                      children: [
                        Image.asset(
                          getIconName(
                            dateTime: hourlyData.datetime,
                            sunrise: sunrise,
                            sunset: sunset,
                            severerisk: hourlyData.severerisk,
                            icon: hourlyData.icon,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${hourlyData.temp.round()} ℃',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              index == 1
                  ? Column(
                      children: [
                        Image.asset(
                          'assets/precip.png',
                          scale: 10,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${hourlyData.precipprob} %',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${hourlyData.precip} mm',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              index == 2
                  ? Column(
                      children: [
                        const SizedBox(height: 15),
                        Transform.rotate(
                          angle: double.parse(hourlyData.winddir.toString()),
                          child: Image.asset(
                            'assets/wind-arrow.png',
                            scale: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${hourlyData.windspeed} km/h',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

String getIconName({
  required String dateTime,
  required String sunrise,
  required String sunset,
  required int severerisk,
  required String icon,
}) {
  final double dateTimeDouble = double.parse(dateTime.substring(0, 2)) +
      double.parse(dateTime.substring(3, 5)) / 60;
  final double sunriseDouble = double.parse(sunrise.substring(0, 2)) +
      double.parse(sunrise.substring(3, 5)) / 60;
  final double sunsetDouble = double.parse(sunset.substring(0, 2)) +
      double.parse(sunset.substring(3, 5)) / 60;
  final bool isDay =
      dateTimeDouble > sunriseDouble && dateTimeDouble < sunsetDouble;

  if (severerisk > 30 && isDay) {
    return 'assets/storm.png';
  } else if (severerisk > 30) {
    return 'assets/night-storm.png';
  } else if (icon == 'rain' && !isDay) {
    return 'assets/night-rain.png';
  } else {
    return 'assets/$icon.png';
  }
}
