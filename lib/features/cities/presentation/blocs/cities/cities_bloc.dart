// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/domain/cities_repository.dart';

part 'cities_event.dart';
part 'cities_state.dart';

@injectable
class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final CitiesRepository _citiesRepository;

  CitiesBloc({
    required CitiesRepository citiesRepository,
  })  : _citiesRepository = citiesRepository,
        super(CitiesLoading()) {
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
