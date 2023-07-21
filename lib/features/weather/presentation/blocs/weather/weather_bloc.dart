import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_model.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherLoading()) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    final WeatherModel? weatherModel =
        await _weatherRepository.getWeatherModel(city: event.city);

    if (weatherModel != null) {
      emit(WeatherLoaded(weatherModel: weatherModel));
    }
  }
}
