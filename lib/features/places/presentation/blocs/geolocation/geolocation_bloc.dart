// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
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
      final CityModel cityModel =
          await _geolocationRepository.getCurrentLocation();
      emit(GeolocationLoaded(cityModel));
    } on Exception catch (e) {
      final String error = e.toString().substring(e.toString().indexOf('l'));

      emit(GeolocationError(error));
    }
  }
}
