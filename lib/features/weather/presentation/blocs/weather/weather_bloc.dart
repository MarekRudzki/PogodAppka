// Dart imports:
import 'dart:async';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(WeatherLoading()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
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
