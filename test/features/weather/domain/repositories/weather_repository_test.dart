import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';

import '../../../../test_helper.dart';

class MockWeatherRemoteDataSource extends Mock
    implements WeatherRemoteDataSource {}

void main() {
  late WeatherRemoteDataSource dataSource;
  late WeatherRepository sut;

  setUp(() => {
        dataSource = MockWeatherRemoteDataSource(),
        sut = WeatherRepository(dataSource),
      });

  group('Weather Repository', () {
    test(
      "gets WeatherData when getWeatherData method is called",
      () async {
        when(() => dataSource.getWeatherData(city: sampleCity.name))
            .thenAnswer((_) async => sampleWeatherJson);

        final weatherData = await sut.getWeatherData(city: sampleCity.name);

        expect(weatherData, sampleWeatherData);
      },
    );
  });
}
