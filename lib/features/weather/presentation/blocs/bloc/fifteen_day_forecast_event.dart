part of 'fifteen_day_forecast_bloc.dart';

class FifteenDayForecastEvent extends Equatable {
  const FifteenDayForecastEvent();

  @override
  List<Object> get props => [];
}

class LoadForecast extends FifteenDayForecastEvent {
  final WeatherData weatherData;

  const LoadForecast({required this.weatherData});

  @override
  List<Object> get props => [weatherData];
}

class ExpandTile extends FifteenDayForecastEvent {
  final int tileIndex;
  final bool isExpanded;
  final WeatherData weatherData;

  const ExpandTile({
    required this.tileIndex,
    required this.weatherData,
    required this.isExpanded,
  });

  @override
  List<Object> get props => [
        tileIndex,
        weatherData,
        isExpanded,
      ];
}
