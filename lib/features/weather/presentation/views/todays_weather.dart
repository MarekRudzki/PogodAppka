import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';

class TodaysWeather extends StatelessWidget {
  const TodaysWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const CircularProgressIndicator();
        } else if (state is WeatherLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  DateTime.now().toString(),
                ),
              ],
            ),
          );
        } else {
          return const Text('Błąd! Coś poszło nie tak');
        }
      },
    );
  }
}
