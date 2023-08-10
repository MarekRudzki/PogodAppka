part of 'fifteen_day_forecast_bloc.dart';

class FifteenDayForecastState extends Equatable {
  const FifteenDayForecastState();

  @override
  List<Object> get props => [];
}

class FifteenDayForecastLoading extends FifteenDayForecastState {}

class FifteenDayForecastLoaded extends FifteenDayForecastState {
  final WeatherData weatherData;
  final List<bool> isExpanded;

  const FifteenDayForecastLoaded({
    required this.weatherData,
    required this.isExpanded,
  });

  @override
  List<Object> get props => [
        weatherData,
        isExpanded,
      ];
}

class FifteenDayForecastError extends FifteenDayForecastState {}
