import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';

import '../../../../../test_helper.dart';

class MockPlaceCoordinatesRepository extends Mock
    implements PlaceCoordinatesRepository {}

void main() {
  late PlaceCoordinatesBloc sut;
  late PlaceCoordinatesRepository placeCoordinatesRepository;

  setUp(() => {
        placeCoordinatesRepository = MockPlaceCoordinatesRepository(),
        sut = PlaceCoordinatesBloc(
            placeCoordinatesRepository: placeCoordinatesRepository),
        when(() =>
            placeCoordinatesRepository.getCoordinates(
                placeId: sampleCity.placeId)).thenAnswer(
            (_) async => PlaceCoordinatesModel(sampleLatitude, sampleLongitude))
      });

  group('Place Coordinates Bloc', () {
    blocTest<PlaceCoordinatesBloc, PlaceCoordinatesState>(
      'emits [PlaceCoordinatesLoading] and [PlaceCoordinatesLoaded] when FetchPlaceCoordinates is added.',
      build: () => sut,
      act: (bloc) =>
          bloc.add(FetchPlaceCoordinates(placeId: sampleCity.placeId)),
      expect: () => [
        PlaceCoordinatesLoading(),
        PlaceCoordinatesLoaded(
            PlaceCoordinatesModel(sampleLatitude, sampleLongitude))
      ],
    );
  });
  tearDown(() => sut.close());
}
