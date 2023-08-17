part of 'fourteen_day_forecast_bloc.dart';

class FourteenDayForecastEvent extends Equatable {
  const FourteenDayForecastEvent();

  @override
  List<Object> get props => [];
}

class LoadForecast extends FourteenDayForecastEvent {
  final WeatherData weatherData;

  const LoadForecast({required this.weatherData});

  @override
  List<Object> get props => [weatherData];
}

class ExpandTile extends FourteenDayForecastEvent {
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
