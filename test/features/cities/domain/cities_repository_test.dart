// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/local_data_sources/cities_local_data_source.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import '../../../test_helper.dart';

class MockCitiesLocalDataSource extends Mock implements CitiesLocalDataSource {}

void main() {
  late CitiesRepository sut;
  late CitiesLocalDataSource dataSource;

  setUp(() => {
        dataSource = MockCitiesLocalDataSource(),
        sut = CitiesRepository(dataSource),
        when(() => dataSource.addLatestCity(
            city: sampleCity.name,
            placeId: sampleCity.placeId)).thenAnswer((_) async {}),
        when(() => dataSource.getLatestCity()).thenReturn(sampleCity.name),
        when(() => dataSource.getLatestPlaceId())
            .thenReturn(sampleCity.placeId),
        when(() => dataSource.getRecentSearces())
            .thenReturn({"city1": "placeId1", "city2": "placeId2"}),
      });

  group('Cities repository', () {
    test(
      "calls [addLatestCity] method once without errors",
      () {
        sut.addLatestCity(cityModel: sampleCity);

        verify(() => dataSource.addLatestCity(
            city: sampleCity.name, placeId: sampleCity.placeId)).called(1);
      },
    );
    test(
      "returns [CityModel] when [getLatestCity] method is called",
      () {
        final latestCity = sut.getLatestCity();

        expect(latestCity, sampleCity);
      },
    );

    test(
      "returns [List<CityModel>] when [getRecentSearches] method is called",
      () {
        final recentSearches = sut.getRecentSearches();

        expect(recentSearches, [
          CityModel(name: 'city1', placeId: 'placeId1'),
          CityModel(name: 'city2', placeId: 'placeId2'),
        ]);
      },
    );
  });
}
