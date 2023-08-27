// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart';
import '../../../../../test_helper.dart';

void main() {
  late FourteenDayForecastBloc fourteenDayForecastBloc;

  setUp(() {
    fourteenDayForecastBloc = FourteenDayForecastBloc();
  });

  group('Fourteen Day Forecast Bloc', () {
    blocTest(
      'should emit [FourteenDayForecastLoading] and [FourteenDayForecastLoaded] '
      'when [LoadForecast] event is called',
      build: () => fourteenDayForecastBloc,
      act: (bloc) => bloc.add(LoadForecast(weatherData: sampleWeatherData)),
      expect: () => [
        FourteenDayForecastLoading(),
        FourteenDayForecastLoaded(
          weatherData: sampleWeatherData,
          isExpanded: List.generate(15, (_) => false),
        ),
      ],
    );

    blocTest(
      'should emit [FourteenDayForecastLoading] when [ExpandTile] event is called '
      'and expand a tile',
      build: () => fourteenDayForecastBloc,
      act: (bloc) => bloc.add(ExpandTile(
          tileIndex: 5, weatherData: sampleWeatherData, isExpanded: false)),
      expect: () => [
        FourteenDayForecastLoaded(
            weatherData: sampleWeatherData,
            isExpanded: getExpandedList(index: 5, initialStatus: false)),
      ],
    );

    blocTest(
      'should emit [FourteenDayForecastLoading] when [ExpandTile] event is called '
      'and roll up a tile',
      build: () => fourteenDayForecastBloc,
      act: (bloc) => bloc.add(ExpandTile(
          tileIndex: 5, weatherData: sampleWeatherData, isExpanded: true)),
      expect: () => [
        FourteenDayForecastLoaded(
            weatherData: sampleWeatherData,
            isExpanded: getExpandedList(index: 5, initialStatus: true)),
      ],
    );
  });

  tearDown(() => {
        fourteenDayForecastBloc.close(),
      });
}
