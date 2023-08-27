// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';
import '../../../../test_helper.dart';

class MockGeolocationRemoteDataSource extends Mock
    implements GeolocationRemoteDataSource {}

void main() {
  late GeolocationRemoteDataSource dataSource;
  late GeolocationRepository sut;

  setUp(() => {
        dataSource = MockGeolocationRemoteDataSource(),
        sut = GeolocationRepository(dataSource),
      });

  group('Geolocation Repository', () {
    test(
      "fetches valid [CityModel] when [getCurrentLocation] method is called",
      () async {
        when(() => dataSource.getCurrentGeolocation()).thenAnswer((_) async => {
              'results': [
                {'place_id': sampleCity.placeId}
              ]
            });
        when(() => dataSource.getAdress())
            .thenAnswer((_) async => sampleCity.name);

        final currentLocation = await sut.getCurrentLocation();

        expect(
            currentLocation,
            CityModel(
              name: sampleCity.name,
              placeId: sampleCity.placeId,
            ));
      },
    );
  });
}
