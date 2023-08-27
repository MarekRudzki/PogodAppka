// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/place_coordinates/data/datasource/place_coordinates_remote_data_source.dart';
import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart';
import '../../../../test_helper.dart';

class MockPlaceCoordinatesRemoteDataSource extends Mock
    implements PlaceCoordinatesRemoteDataSource {}

void main() {
  late PlaceCoordinatesRepository sut;
  late PlaceCoordinatesRemoteDataSource dataSource;

  setUp(() => {
        dataSource = MockPlaceCoordinatesRemoteDataSource(),
        sut = PlaceCoordinatesRepository(dataSource),
      });

  group('Place Coordinates Repository', () {
    test(
      "gets initial coordinates when [getCoordinates] method is called with null response",
      () async {
        when(() => dataSource.getPlaceCoordinates(placeId: sampleCity.placeId))
            .thenAnswer((_) async => null);

        final placeCoordinatesModel =
            await sut.getCoordinates(placeId: sampleCity.placeId);

        expect(
          placeCoordinatesModel,
          PlaceCoordinatesModel(52.069337, 19.480245),
        );
      },
    );

    test(
      "returns valid [PlaceCoordinatesModel] when [getCoordinates] method is called",
      () async {
        when(() => dataSource.getPlaceCoordinates(placeId: sampleCity.placeId))
            .thenAnswer((_) async => {
                  "result": {
                    "geometry": {
                      "location": {
                        'lat': sampleLatitude,
                        'lng': sampleLongitude
                      }
                    }
                  }
                });

        final placeCoordinatesModel =
            await sut.getCoordinates(placeId: sampleCity.placeId);

        expect(placeCoordinatesModel,
            PlaceCoordinatesModel(sampleLatitude, sampleLongitude));
      },
    );
  });
}
