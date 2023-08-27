// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import '../../../../../test_helper.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherRepository weatherRepository;
  late WeatherBloc sut;

  setUp(() => {
        weatherRepository = MockWeatherRepository(),
        sut = WeatherBloc(weatherRepository: weatherRepository),
      });

  group('Weather Bloc', () {
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading] and [WeatherLoaded] when FetchWeather is added.',
      build: () {
        when(() => weatherRepository.getWeatherData(city: sampleCity.name))
            .thenAnswer((_) async => sampleWeatherData);
        return sut;
      },
      act: (bloc) => bloc.add(FetchWeather(city: sampleCity.name)),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(weatherData: sampleWeatherData),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading] and [WeatherError] when FetchWeather is added.',
      build: () {
        when(() => weatherRepository.getWeatherData(city: sampleCity.name))
            .thenThrow(Exception());
        return sut;
      },
      act: (bloc) => bloc.add(FetchWeather(city: sampleCity.name)),
      expect: () => [
        WeatherLoading(),
        WeatherError(),
      ],
    );
  });
}
