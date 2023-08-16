// ignore_for_file: unused_element

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';

part 'place_coordinates_event.dart';
part 'place_coordinates_state.dart';

class PlaceCoordinatesBloc
    extends Bloc<PlaceCoordinatesEvent, PlaceCoordinatesState> {
  // ignore: unused_field
  final GeolocationBloc _geolocationBloc;
  late StreamSubscription<GeolocationState> _streamSubscription;
  final PlaceCoordinatesRepository _placeCoordinatesRepository;

  PlaceCoordinatesBloc({
    required PlaceCoordinatesRepository placeCoordinatesRepository,
    required GeolocationBloc geolocationBloc,
  })  : _placeCoordinatesRepository = placeCoordinatesRepository,
        _geolocationBloc = geolocationBloc,
        super(PlaceCoordinatesLoading()) {
    _streamSubscription = geolocationBloc.stream.listen((state) {
      if (state is GeolocationLoaded) {
        add(FetchPlaceCoordinates(placeId: state.cityModel.placeId));
      }
    });

    @override
    Future<void> close() {
      _streamSubscription.cancel();
      return super.close();
    }

    on<FetchPlaceCoordinates>(_onFetchPlaceCoordinates);
  }

  Future<void> _onFetchPlaceCoordinates(
      FetchPlaceCoordinates event, Emitter<PlaceCoordinatesState> emit) async {
    emit(PlaceCoordinatesLoading());

    final PlaceCooridnatesModel placeCooridnatesModel =
        await _placeCoordinatesRepository.getCoordinates(
            placeId: event.placeId);

    emit(PlaceCoordinatesLoaded(placeCooridnatesModel));
  }
}
