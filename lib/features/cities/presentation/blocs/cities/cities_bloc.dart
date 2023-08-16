// ignore_for_file: unused_field, unused_element

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final GeolocationBloc _geolocationBloc;
  late StreamSubscription<GeolocationState> _streamSubscription;
  final CitiesRepository _citiesRepository;

  CitiesBloc({
    required CitiesRepository citiesRepository,
    required GeolocationBloc geolocationBloc,
  })  : _citiesRepository = citiesRepository,
        _geolocationBloc = geolocationBloc,
        super(CitiesLoading()) {
    _streamSubscription = geolocationBloc.stream.listen(
      (state) {
        if (state is GeolocationLoaded) {
          add(
            AddLatestCity(
              cityModel: CityModel(
                name: state.cityModel.name,
                placeId: state.cityModel.placeId,
              ),
            ),
          );
        }
      },
    );

    @override
    Future<void> close() {
      _streamSubscription.cancel();
      return super.close();
    }

    on<LoadLatestCity>(_onLoadLatestCity);
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<AddLatestCity>(_onAddLatestCity);
  }

  Future<void> _onLoadLatestCity(
    LoadLatestCity event,
    Emitter<CitiesState> emit,
  ) async {
    emit(
      LatestCityLoaded(
        cityModel: CityModel(
          name: _citiesRepository.getLatestCity().name,
          placeId: _citiesRepository.getLatestCity().placeId,
        ),
      ),
    );
  }

  Future<void> _onLoadRecentSearches(
    LoadRecentSearches event,
    Emitter<CitiesState> emit,
  ) async {
    final List<CityModel> recentSearches =
        _citiesRepository.getRecentSearches();
    emit(RecentSearchesLoaded(recentSearches));
  }

  Future<void> _onAddLatestCity(
    AddLatestCity event,
    Emitter<CitiesState> emit,
  ) async {
    await _citiesRepository.addLatestCity(
      cityModel: CityModel(
        name: event.cityModel.name,
        placeId: event.cityModel.placeId,
      ),
    );
    emit(
      LatestCityLoaded(
        cityModel: CityModel(
          name: event.cityModel.name,
          placeId: event.cityModel.placeId,
        ),
      ),
    );
  }
}
