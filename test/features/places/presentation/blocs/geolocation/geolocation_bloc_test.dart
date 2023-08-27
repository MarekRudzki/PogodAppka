import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';

import '../../../../../test_helper.dart';

class MockGeolocationRepository extends Mock implements GeolocationRepository {}

void main() {
  late GeolocationBloc sut;
  late GeolocationRepository geolocationRepository;

  setUp(() => {
        geolocationRepository = MockGeolocationRepository(),
        sut = GeolocationBloc(geolocationRepository: geolocationRepository),
      });

  group('Geolocation Bloc', () {
    blocTest(
      'emits [GeolocationLoading] and [GeolocationLoaded] when LoadGeolocation is added .',
      build: () {
        when(() => geolocationRepository.getCurrentLocation())
            .thenAnswer((_) async => CityModel(
                  name: sampleCity.name,
                  placeId: sampleCity.placeId,
                ));
        return sut;
      },
      act: (bloc) => bloc.add(LoadGeolocation()),
      expect: () => [
        GeolocationLoading(),
        GeolocationLoaded(
          CityModel(
            name: sampleCity.name,
            placeId: sampleCity.placeId,
          ),
        )
      ],
    );

    blocTest(
      'emits [GeolocationLoading] and [GeolocationError] when LoadGeolocation is added and Exception occurs.',
      build: () {
        when(() => geolocationRepository.getCurrentLocation())
            .thenThrow(Exception('location-error'));
        return sut;
      },
      act: (bloc) => bloc.add(LoadGeolocation()),
      expect: () => [
        GeolocationLoading(),
        const GeolocationError('location-error'),
      ],
    );
  });

  tearDown(() => sut.close());
}
