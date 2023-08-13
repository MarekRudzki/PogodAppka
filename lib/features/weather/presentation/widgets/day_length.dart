import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayLength extends StatelessWidget {
  final String sunset;
  final String sunrise;

  const DayLength({
    super.key,
    required this.sunset,
    required this.sunrise,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('HH:mm');
    final DateTime sunriseHour = format.parse(sunrise);
    final DateTime sunsetHour = format.parse(sunset);
    final double screenWidth = MediaQuery.of(context).size.width;

    final String difference = sunsetHour.difference(sunriseHour).toString();
    final String dayHours = difference.substring(0, difference.indexOf(':'));
    final String dayMinutes = difference.substring(
        difference.indexOf(':') + 1, difference.lastIndexOf(':'));
    final double dayLengthPercentage =
        (int.parse(dayHours) + (int.parse(dayMinutes) / 60)) / 24;

    final String nightLength = ((1 - dayLengthPercentage) * 24).toString();
    final String nightHours =
        nightLength.substring(0, nightLength.indexOf('.'));

    final int nightMinutes =
        ((double.parse(nightLength) - double.parse(nightHours)) * 60).round();

    final int addToFullHour =
        nightMinutes + int.parse(dayMinutes) == 60 ? 0 : 1;
    final String nightMinutesText = nightMinutes < 10
        ? '0${nightMinutes + addToFullHour}'.substring(0, 2)
        : '${nightMinutes + addToFullHour}'.substring(0, 2);

    return Column(
      children: [
        const SizedBox(height: 15),
        const Text(
          'Długość dnia i nocy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Container(
                height: double.infinity,
                color: const Color.fromARGB(255, 244, 223, 122),
                width: dayLengthPercentage * screenWidth - 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wb_sunny_outlined,
                      color: Color.fromARGB(255, 181, 164, 18),
                      size: 30,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$dayHours:$dayMinutes',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: const Color.fromRGBO(0, 47, 91, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scaleX: -1,
                        child: const Icon(
                          Icons.brightness_2_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$nightHours:$nightMinutesText',
                        // nightLength,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
