// ignore_for_file: unused_field

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final GeolocationBloc _geolocationBloc;
  late StreamSubscription _streamSubscription;
  final CitiesRepository _citiesRepository;
  CitiesBloc(
      {required CitiesRepository citiesRepository,
      required GeolocationBloc geolocationBloc})
      : _citiesRepository = citiesRepository,
        _geolocationBloc = geolocationBloc,
        super(CitiesLoading()) {
    _streamSubscription = geolocationBloc.stream.listen((state) {
      if (state is GeolocationLoaded) {
        add(AddLatestCity(city: state.city));
      }
    });

    on<LoadLatestCity>(_onLoadLatestCity);
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<AddLatestCity>(_onAddLatestCity);
  }

  void _onLoadLatestCity(
    LoadLatestCity event,
    Emitter<CitiesState> emit,
  ) async {
    final String latestCity = _citiesRepository.getLatestCity();
    emit(LatestCityLoaded(latestCity));
  }

  void _onLoadRecentSearches(
    LoadRecentSearches event,
    Emitter<CitiesState> emit,
  ) async {
    final List<String> recentSearches = _citiesRepository.getRecentSearches();
    emit(RecentSearchesLoaded(recentSearches));
  }

  void _onAddLatestCity(
    AddLatestCity event,
    Emitter<CitiesState> emit,
  ) async {
    await _citiesRepository.addLatestCity(city: event.city);
    emit(LatestCityLoaded(event.city));
  }
}
