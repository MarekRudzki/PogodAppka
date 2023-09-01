part of 'fourteen_day_forecast_bloc.dart';

class FourteenDayForecastState extends Equatable {
  const FourteenDayForecastState();

  @override
  List<Object> get props => [];
}

class FourteenDayForecastLoading extends FourteenDayForecastState {
  @override
  List<Object> get props => [];
}

class FourteenDayForecastLoaded extends FourteenDayForecastState {
  final WeatherData weatherData;
  final List<bool> isExpanded;

  const FourteenDayForecastLoaded({
    required this.weatherData,
    required this.isExpanded,
  });

  @override
  List<Object> get props => [
        weatherData,
        isExpanded,
      ];
}
