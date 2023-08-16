part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final CityModel cityModel;

  const GeolocationLoaded(this.cityModel);

  @override
  List<Object> get props => [cityModel];
}

class GeolocationError extends GeolocationState {
  final String errorMessage;

  const GeolocationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
