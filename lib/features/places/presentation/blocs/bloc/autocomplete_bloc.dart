import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
  }

  void _onLoadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    final List<PlaceAutocompleteModel> autocomplete =
        await _placesRepository.getAutocomplete(city: event.searchInput);

    emit(AutocompleteLoaded(places: autocomplete));
  }

  @override
  Stream<AutocompleteState> mapEventToState(
    AutocompleteEvent event,
  ) async* {
    if (event is LoadAutocomplete) {
      yield* _mapLoadAutocompleteToState(event);
    }
  }

  Stream<AutocompleteState> _mapLoadAutocompleteToState(
      LoadAutocomplete event) async* {
    _placesSubscription?.cancel();

    final List<PlaceAutocompleteModel> autocomplete =
        await _placesRepository.getAutocomplete(city: event.searchInput);

    yield AutocompleteLoaded(places: autocomplete);
  }
}
