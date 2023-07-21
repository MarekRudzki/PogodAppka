part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;

  const WeatherLoaded({required this.weatherModel});

  @override
  List<Object> get props => [weatherModel];
}

class WeatherError extends WeatherState {}
