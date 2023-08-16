// ignore_for_file: unused_field

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  final GeolocationBloc _geolocationBloc;
  final CitiesBloc _citiesBloc;
  late StreamSubscription _citiesStreamSubscription;
  late StreamSubscription _streamSubscription;

  WeatherBloc({
    required WeatherRepository weatherRepository,
    required GeolocationBloc geolocationBloc,
    required CitiesBloc citiesBloc,
  })  : _weatherRepository = weatherRepository,
        _geolocationBloc = geolocationBloc,
        _citiesBloc = citiesBloc,
        super(WeatherLoading()) {
    _streamSubscription = geolocationBloc.stream.listen(
      (state) {
        if (state is GeolocationLoaded) {
          add(FetchWeather(city: state.cityModel.name));
        }
      },
    );
    _citiesStreamSubscription = citiesBloc.stream.listen((state) {
      if (state is LatestCityLoaded) {
        add(FetchWeather(city: state.cityModel.name));
      }
    });

    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final WeatherData? weatherData =
          await _weatherRepository.getWeatherData(city: event.city);

      emit(WeatherLoaded(weatherData: weatherData!));
    } on Exception {
      emit(WeatherError());
    }
  }
}
