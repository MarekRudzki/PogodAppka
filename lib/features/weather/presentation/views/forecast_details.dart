import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/day_description.dart';
import 'package:pogodappka/features/weather/presentation/widgets/weather_tile.dart';

class ForecastDetails extends StatelessWidget {
  final DateTime date;
  const ForecastDetails({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherLoaded) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            DayDescription(date: date),
                            const Spacer(),
                            Text(
                              '${state.weatherModel.currentTemperature.toString()} ℃',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/${state.weatherModel.iconName}.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 300,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Row(
                        children: [
                          WeatherTile(
                            hour: '11:00',
                            assetName: 'assets/clear-day.png',
                            precip: state.weatherModel.precip,
                            windDir: state.weatherModel.winddir,
                            windSpeed: state.weatherModel.windspeed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Błąd! Coś poszło nie tak');
        }
      },
    );
  }
}
