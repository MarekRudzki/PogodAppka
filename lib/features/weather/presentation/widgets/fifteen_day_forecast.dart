import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast_details.dart';

class FifteenDayForecast extends StatefulWidget {
  const FifteenDayForecast({super.key});

  @override
  State<FifteenDayForecast> createState() => _FifteenDayForecastState();
}

class _FifteenDayForecastState extends State<FifteenDayForecast> {
  final List<bool> _isExpanded = List.generate(15, (_) => false);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeatherBloc>().state;
    late List<WeatherDataModel> weatherData;
    if (state is WeatherLoading) {
      return Center(
        child: Image.asset(
          'assets/waiting_animation.gif',
          width: 200,
        ),
      );
    }
    if (state is WeatherLoaded) {
      weatherData = state.weatherData.weatherDataModel;
      return SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) => setState(() {
            if (_isExpanded.contains(true)) {
              final valueToReset = _isExpanded.indexOf(true);
              _isExpanded[valueToReset] = false;
            }
            _isExpanded[index + 2] = !isExpanded;
          }),
          animationDuration: const Duration(milliseconds: 1500),
          children: [
            for (int i = 2; i < 15; i++)
              ExpansionPanel(
                backgroundColor: Colors.tealAccent,
                isExpanded: _isExpanded[i],
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            toBeginningOfSentenceCase(
                              DateFormat('EEEE', 'pl').format(DateTime.parse(
                                  weatherData[i].dailyWeatherData.dateTime)),
                            ).toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 167, 167, 167),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            toBeginningOfSentenceCase(
                              DateFormat('d MMMM', 'pl').format(DateTime.parse(
                                  weatherData[i].dailyWeatherData.dateTime)),
                            ).toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 167, 167, 167),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text('${weatherData[i].dailyWeatherData.tempMax} ℃'),
                      const SizedBox(width: 40),
                      Image.asset(
                        showWeatherIcon(
                          severerisk:
                              weatherData[i].dailyWeatherData.severerisk,
                          icon: weatherData[i].dailyWeatherData.icon,
                        ),
                        scale: 10,
                      ),
                    ],
                  ),
                ),
                body: ForecastDetails(day: i),
              ),
          ],
        ),
      );
    } else {
      return const Text('Nie można było załadować pogody');
    }
  }
}

String showWeatherIcon({
  required int severerisk,
  required String icon,
}) {
  if (severerisk > 30) {
    return 'assets/storm.png';
  } else {
    return 'assets/$icon.png';
  }
}
