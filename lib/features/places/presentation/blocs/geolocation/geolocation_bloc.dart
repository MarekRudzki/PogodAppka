import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

@injectable
class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;

  GeolocationBloc({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(GeolocationInitial()) {
    on<LoadGeolocation>(_onLoadGeolocation);
  }

  Future<void> _onLoadGeolocation(
    LoadGeolocation event,
    Emitter<GeolocationState> emit,
  ) async {
    emit(GeolocationLoading());

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const GeolocationError('location-off'));
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          emit(
            const GeolocationError(
              'location-deniedForever',
            ),
          );
          return;
        }
      }

      final CityModel cityModel =
          await _geolocationRepository.getCurrentLocation();
      emit(GeolocationLoaded(cityModel));
    } on Exception {
      emit(const GeolocationError(
          'Obecnie nie można zlokalizować Twojej pozycji. Spróbuj wyszukać ją ręcznie'));
    }
  }
}
