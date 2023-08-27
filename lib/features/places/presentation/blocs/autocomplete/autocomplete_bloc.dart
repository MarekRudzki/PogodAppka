// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';
import 'package:pogodappka/features/places/domain/repositories/autocomplete_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

@injectable
class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final AutocompleteRepository _autocompleteRepository;

  AutocompleteBloc({required AutocompleteRepository autocompleteRepository})
      : _autocompleteRepository = autocompleteRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
    on<ClearAutocomplete>(_onClearAutocomplete);
  }

  Future<void> _onLoadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    final List<PlaceAutocompleteModel> autocomplete =
        await _autocompleteRepository.getAutocomplete(city: event.searchInput);

    emit(AutocompleteLoaded(places: autocomplete));
  }

  void _onClearAutocomplete(
    ClearAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) {
    emit(const AutocompleteLoaded(places: []));
  }
}
