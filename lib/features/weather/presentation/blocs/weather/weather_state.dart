part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherData weatherData;

  const WeatherLoaded({
    required this.weatherData,
  });

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  @override
  List<Object> get props => [];
}
