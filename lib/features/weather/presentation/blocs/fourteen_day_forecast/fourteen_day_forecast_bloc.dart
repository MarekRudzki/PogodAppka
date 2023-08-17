// ignore_for_file: unused_field, unused_element

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';

part 'fourteen_day_forecast_event.dart';
part 'fourteen_day_forecast_state.dart';

class FourteenDayForecastBloc
    extends Bloc<FourteenDayForecastEvent, FourteenDayForecastState> {
  final WeatherBloc _weatherBloc;
  late StreamSubscription<WeatherState> _streamSubscription;

  FourteenDayForecastBloc({required WeatherBloc weatherBloc})
      : _weatherBloc = weatherBloc,
        super(FourteenDayForecastLoading()) {
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
    Emitter<FourteenDayForecastState> emit,
  ) {
    emit(FourteenDayForecastLoading());
    emit(
      FourteenDayForecastLoaded(
          weatherData: event.weatherData,
          isExpanded: List.generate(15, (_) => false)),
    );
  }

  void _onExpandTile(
    ExpandTile event,
    Emitter<FourteenDayForecastState> emit,
  ) {
    final defaultList = List.generate(15, (_) => false);
    defaultList[event.tileIndex + 2] = !event.isExpanded;
    emit(FourteenDayForecastLoaded(
      weatherData: event.weatherData,
      isExpanded: defaultList,
    ));
  }
}
