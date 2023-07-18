import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart';
import 'package:pogodappka/features/places/presentation/blocs/bloc/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/views/home_screen.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(const LoadAutocomplete()))
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
