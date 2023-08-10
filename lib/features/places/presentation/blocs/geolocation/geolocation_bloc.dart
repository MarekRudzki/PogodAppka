import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
    on<CheckPermission>(_onCheckPermission);
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

  void _onCheckPermission(
    CheckPermission event,
    Emitter<GeolocationState> emit,
  ) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const GeolocationError('Lokalizacja jest wyłączona'));
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        emit(
          const GeolocationError(
            'Lokalizacja jest wyłączona na stałe, nie można zlokalizować Twojej pozycji',
          ),
        );
        return;
      }
    }
  }
}
