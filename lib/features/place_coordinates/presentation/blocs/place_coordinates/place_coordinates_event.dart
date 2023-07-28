part of 'place_coordinates_bloc.dart';

abstract class PlaceCoordinatesEvent extends Equatable {
  const PlaceCoordinatesEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaceCoordinates extends PlaceCoordinatesEvent {
  final String placeId;

  const FetchPlaceCoordinates({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}
