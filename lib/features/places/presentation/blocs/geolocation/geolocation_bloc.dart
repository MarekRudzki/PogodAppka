import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;

  GeolocationBloc({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(GeolocationLoading()) {
    on<LoadGeolocation>(_onLoadGeolocation);
  }
  void _onLoadGeolocation(
    LoadGeolocation event,
    Emitter<GeolocationState> emit,
  ) async {
    emit(GeolocationLoading());

    final CityModel cityModel =
        await _geolocationRepository.getCurrentLocation();

    emit(GeolocationLoaded(cityModel));
  }
}
