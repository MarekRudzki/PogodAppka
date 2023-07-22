import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart';
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';
import 'package:pogodappka/features/places/presentation/views/home_screen.dart';
import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  initializeDateFormatting('pl').then(
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
            create: (context) => GeolocationRepository(),
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
              create: (context) => WeatherBloc(
                  weatherRepository: context.read<WeatherRepository>())
                ..add(
                  const FetchWeather(),
                ),
            ),
            BlocProvider(
                create: (context) => GeolocationBloc(
                    geolocationRepository:
                        context.read<GeolocationRepository>())),
          ],
          child: const MaterialApp(
            title: 'Pogodappka',
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        ),
      ),
    ),
  );
}
