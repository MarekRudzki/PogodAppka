import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart';

part 'place_coordinates_event.dart';
part 'place_coordinates_state.dart';

class PlaceCoordinatesBloc
    extends Bloc<PlaceCoordinatesEvent, PlaceCoordinatesState> {
  final PlaceCoordinatesRepository _placeCoordinatesRepository;
  PlaceCoordinatesBloc(PlaceCoordinatesRepository placeCoordinatesRepository)
      : _placeCoordinatesRepository = placeCoordinatesRepository,
        super(PlaceCoordinatesLoading()) {
    on<FetchPlaceCoordinates>(_onFetchPlaceCoordinates);
  }

  void _onFetchPlaceCoordinates(
      FetchPlaceCoordinates event, Emitter<PlaceCoordinatesState> emit) async {
    emit(PlaceCoordinatesLoading());

    PlaceCooridnatesModel placeCooridnatesModel =
        await _placeCoordinatesRepository.getCoordinates(
            placeId: event.placeId);

    emit(PlaceCoordinatesLoaded(placeCooridnatesModel));
  }
}
