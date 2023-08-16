import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';

import 'package:pogodappka/features/cities/data/local_data_sources/cities_local_data_source.dart';
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/place_coordinates/data/datasource/place_coordinates_remote_data_source.dart';
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart';
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';
import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fifteen_day_forecast/fifteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/views/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cities_box');

  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => initializeDateFormatting('pl').then(
      (_) => runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => PlacesRepository(
                PlacesRemoteDataSource(),
              ),
            ),
            RepositoryProvider(
              create: (context) => WeatherRepository(
                WeatherRemoteDataSource(),
              ),
            ),
            RepositoryProvider(
              create: (context) => GeolocationRepository(
                GeolocationRemoteDataSource(),
              ),
            ),
            RepositoryProvider(
              create: (context) => CitiesRepository(
                CitiesLocalDataSource(),
              ),
            ),
            RepositoryProvider(
              create: (context) => PlaceCoordinatesRepository(
                PlaceCoordinatesRemoteDataSource(),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AutocompleteBloc(
                    placesRepository: context.read<PlacesRepository>())
                  ..add(
                    const LoadAutocomplete(),
                  ),
              ),
              BlocProvider(
                create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => CitiesBloc(
                  geolocationBloc: context.read<GeolocationBloc>(),
                  citiesRepository: context.read<CitiesRepository>(),
                )..add(
                    LoadLatestCity(),
                  ),
              ),
              BlocProvider(
                create: (context) => WeatherBloc(
                  geolocationBloc: context.read<GeolocationBloc>(),
                  citiesBloc: context.read<CitiesBloc>(),
                  weatherRepository: context.read<WeatherRepository>(),
                )..add(
                    FetchWeather(
                        city: context
                            .read<CitiesRepository>()
                            .getLatestCity()
                            .name),
                  ),
              ),
              BlocProvider(
                create: (context) => PlaceCoordinatesBloc(
                  placeCoordinatesRepository:
                      context.read<PlaceCoordinatesRepository>(),
                  geolocationBloc: context.read<GeolocationBloc>(),
                )..add(
                    FetchPlaceCoordinates(
                        placeId: context
                            .read<CitiesRepository>()
                            .getLatestCity()
                            .placeId),
                  ),
              ),
              BlocProvider(
                create: (context) => FifteenDayForecastBloc(
                  weatherBloc: context.read<WeatherBloc>()
                    ..add(
                      FetchWeather(
                        city: context
                            .read<CitiesRepository>()
                            .getLatestCity()
                            .name,
                      ),
                    ),
                ),
              ),
            ],
            child: const MaterialApp(
              title: 'Pogodappka',
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          ),
        ),
      ),
    ),
  );
}
