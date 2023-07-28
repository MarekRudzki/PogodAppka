import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutocompleteLoaded) {
          if (state.places.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) => LocationListTile(
                  location: state.places[index].description,
                  callback: () {
                    String adress = state.places[index].description;
                    String placeId = state.places[index].placeId;

                    String city = adress.substring(0, adress.indexOf(','));
                    context.read<CitiesBloc>().add(AddLatestCity(
                        cityModel: CityModel(name: city, placeId: placeId)));
                    context.read<WeatherBloc>().add(FetchWeather(city: city));
                    context.read<PlaceCoordinatesBloc>().add(
                        FetchPlaceCoordinates(
                            placeId: state.places[index].placeId));

                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          } else {
            return BlocBuilder<CitiesBloc, CitiesState>(
              builder: (context, state) {
                if (state is CitiesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RecentSearchesLoaded) {
                  final cities = state.recentSearches.reversed.toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) => LocationListTile(
                        location: cities[index].name,
                        callback: () {
                          String city = cities[index].name;
                          String placeId = cities[index].placeId;

                          context.read<CitiesBloc>().add(AddLatestCity(
                              cityModel:
                                  CityModel(name: city, placeId: placeId)));
                          context
                              .read<WeatherBloc>()
                              .add(FetchWeather(city: city));
                          context
                              .read<PlaceCoordinatesBloc>()
                              .add(FetchPlaceCoordinates(placeId: placeId));

                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Nie można było załadować elementu',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            );
          }
        } else {
          return const Center(
            child: Text(
              'Nie można było załadować elementu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
