// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/places/data/datasources/autocomplete_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/autocomplete_repository.dart';
import '../../../../test_helper.dart';

class MockAutocompleteRemoteDataSource extends Mock
    implements AutocompleteRemoteDataSource {}

void main() {
  late AutocompleteRemoteDataSource dataSource;
  late AutocompleteRepository sut;

  setUp(() => {
        dataSource = MockAutocompleteRemoteDataSource(),
        sut = AutocompleteRepository(dataSource),
      });

  group('Autocomplete Repository', () {
    test(
      "gets [List<PlaceAutocompleteModel>] when [getAutocomplete] method is called",
      () async {
        when(() => dataSource.getPlaces(city: sampleCity.name))
            .thenAnswer((_) async => autocompleteReposnse);

        final responsePlaces = await sut.getAutocomplete(city: sampleCity.name);

        expect(responsePlaces, autocompletePlaces);
      },
    );
  });
}
