import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/presentation/widgets/weather_tile.dart';

class HourlyDetails extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  final int day;
  final DateTime localDateTime;
  final String sunrise;
  final String sunset;

  const HourlyDetails({
    super.key,
    required this.weatherDataHourly,
    required this.sunrise,
    required this.sunset,
    required this.day,
    required this.localDateTime,
  });

  @override
  State<HourlyDetails> createState() => _HourlyDetailsState();
}

class _HourlyDetailsState extends State<HourlyDetails> {
  ScrollController _scrollController = ScrollController();
  final int itemWidth = 70;

  @override
  void initState() {
    if (widget.day != 0) {
      _scrollController = ScrollController(initialScrollOffset: itemWidth * 6);
    } else {
      _scrollController = ScrollController(
          initialScrollOffset: itemWidth * (widget.localDateTime.hour - 1.0));
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.weatherDataHourly.hourly.length,
              itemBuilder: (context, index) => WeatherTile(
                hourlyData: widget.weatherDataHourly.hourly[index],
                sunrise: widget.sunrise,
                sunset: widget.sunset,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
