part of 'place_coordinates_bloc.dart';

abstract class PlaceCoordinatesState extends Equatable {
  const PlaceCoordinatesState();

  @override
  List<Object> get props => [];
}

class PlaceCoordinatesLoading extends PlaceCoordinatesState {}

class PlaceCoordinatesLoaded extends PlaceCoordinatesState {
  final PlaceCoordinatesModel placeCooridnatesModel;

  const PlaceCoordinatesLoaded(this.placeCooridnatesModel);

  @override
  List<Object> get props => [placeCooridnatesModel];
}
