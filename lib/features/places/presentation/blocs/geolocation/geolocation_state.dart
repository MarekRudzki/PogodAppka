part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final String city;

  const GeolocationLoaded(this.city);

  @override
  List<Object> get props => [city];
}

class GeolocationError extends GeolocationState {}
