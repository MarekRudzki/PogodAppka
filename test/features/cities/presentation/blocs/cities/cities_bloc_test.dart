// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import '../../../../../test_helper.dart';

class MockCitiesRepository extends Mock implements CitiesRepository {}

void main() {
  late CitiesBloc sut;
  late CitiesRepository citiesRepository;

  setUp(() {
    citiesRepository = MockCitiesRepository();
    sut = CitiesBloc(
      citiesRepository: citiesRepository,
    );
    when(() => citiesRepository.getLatestCity()).thenReturn(sampleCity);
    when(() => citiesRepository.getRecentSearches())
        .thenReturn(sampleCitiesList);
    when(() => citiesRepository.addLatestCity(cityModel: sampleCity))
        .thenAnswer((_) async {});
  });
  group('Cities Bloc', () {
    blocTest<CitiesBloc, CitiesState>(
      'emits [LatestCityLoaded] when LoadLatestCity is added.',
      build: () => sut,
      act: (bloc) => bloc.add(LoadLatestCity()),
      expect: () => [
        LatestCityLoaded(cityModel: sampleCity),
      ],
    );
    blocTest<CitiesBloc, CitiesState>(
      'emits [RecentSearchesLoaded] when LoadRecentSearches is added.',
      build: () => sut,
      act: (bloc) => bloc.add(LoadRecentSearches()),
      expect: () => [
        RecentSearchesLoaded(sampleCitiesList),
      ],
    );

    blocTest<CitiesBloc, CitiesState>(
      'emits [LatestCityLoaded] when AddLatestCity is added.',
      build: () => sut,
      act: (bloc) => bloc.add(AddLatestCity(cityModel: sampleCity)),
      expect: () => [
        LatestCityLoaded(cityModel: sampleCity),
      ],
    );

    tearDown(() => {
          sut.close(),
        });
  });
}
