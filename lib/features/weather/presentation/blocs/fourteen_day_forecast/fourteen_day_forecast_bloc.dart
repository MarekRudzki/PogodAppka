// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

part 'fourteen_day_forecast_event.dart';
part 'fourteen_day_forecast_state.dart';

@injectable
class FourteenDayForecastBloc
    extends Bloc<FourteenDayForecastEvent, FourteenDayForecastState> {
  FourteenDayForecastBloc() : super(FourteenDayForecastLoading()) {
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
