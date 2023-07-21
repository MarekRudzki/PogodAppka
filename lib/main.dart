import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/views/home_screen.dart';
import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
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
        )
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
              ..add(const FetchWeather()),
          )
        ],
        child: const MaterialApp(
          title: 'Pogodappka',
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    ),
  );
}
