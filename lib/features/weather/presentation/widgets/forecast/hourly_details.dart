import 'package:flutter/material.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/weather_tile.dart';

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

class _HourlyDetailsState extends State<HourlyDetails>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  final int itemWidth = 70;

  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.day != 0) {
      _scrollController = ScrollController(initialScrollOffset: itemWidth * 6);
    } else {
      _scrollController = ScrollController(
          initialScrollOffset: itemWidth * (widget.localDateTime.hour + 0.0));
    }

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Temperatura'),
            Tab(text: 'Opady'),
            Tab(text: 'Wiatr'),
          ],
        ),
        Container(
          height: 140,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Color.fromARGB(255, 8, 180, 160),
          ),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.weatherDataHourly.hourly.length,
            itemBuilder: (context, index) => WeatherTile(
              hourlyData: widget.weatherDataHourly.hourly[index],
              sunrise: widget.sunrise,
              sunset: widget.sunset,
              index: _selectedIndex,
            ),
          ),
        ),
      ],
    );
  }
}
