// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:pogodappka/features/places/domain/repositories/autocomplete_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import '../../../../../test_helper.dart';

class MockAutocompleteRepository extends Mock
    implements AutocompleteRepository {}

void main() {
  late AutocompleteRepository autocompleteRepository;
  late AutocompleteBloc sut;

  setUp(() => {
        autocompleteRepository = MockAutocompleteRepository(),
        sut = AutocompleteBloc(autocompleteRepository: autocompleteRepository),
      });

  group('Autocomplete Bloc', () {
    blocTest<AutocompleteBloc, AutocompleteState>(
      'emits [AutocompleteLoaded] with empty list when ClearAutocomplete is added.',
      build: () => sut,
      act: (bloc) => bloc.add(ClearAutocomplete()),
      expect: () => [const AutocompleteLoaded(places: [])],
    );
    blocTest<AutocompleteBloc, AutocompleteState>(
      'emits [AutocompleteLoaded] when LoadAutocomplete is added.',
      build: () {
        when(() => autocompleteRepository.getAutocomplete(city: 'city'))
            .thenAnswer((_) async => autocompletePlaces);
        return sut;
      },
      act: (bloc) => bloc.add(const LoadAutocomplete(searchInput: 'city')),
      expect: () => [
        AutocompleteLoaded(places: autocompletePlaces),
      ],
    );
  });
}
