// ignore_for_file: unused_field, unused_element

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';

part 'fifteen_day_forecast_event.dart';
part 'fifteen_day_forecast_state.dart';

class FifteenDayForecastBloc
    extends Bloc<FifteenDayForecastEvent, FifteenDayForecastState> {
  final WeatherBloc _weatherBloc;
  late StreamSubscription<WeatherState> _streamSubscription;

  FifteenDayForecastBloc({required WeatherBloc weatherBloc})
      : _weatherBloc = weatherBloc,
        super(FifteenDayForecastLoading()) {
    _streamSubscription = weatherBloc.stream.listen(
      (state) {
        if (state is WeatherLoaded) {
          add(LoadForecast(weatherData: state.weatherData));
        }
      },
    );

    @override
    Future<void> close() {
      _streamSubscription.cancel();
      return super.close();
    }

    on<LoadForecast>(_onLoadForecast);
    on<ExpandTile>(_onExpandTile);
  }

  void _onLoadForecast(
    LoadForecast event,
    Emitter<FifteenDayForecastState> emit,
  ) {
    emit(FifteenDayForecastLoading());
    emit(
      FifteenDayForecastLoaded(
          weatherData: event.weatherData,
          isExpanded: List.generate(15, (_) => false)),
    );
  }

  void _onExpandTile(
    ExpandTile event,
    Emitter<FifteenDayForecastState> emit,
  ) {
    final defaultList = List.generate(15, (_) => false);
    defaultList[event.tileIndex + 2] = !event.isExpanded;
    emit(FifteenDayForecastLoaded(
      weatherData: event.weatherData,
      isExpanded: defaultList,
    ));
  }
}
