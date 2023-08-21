// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/views/home_screen.dart';

class SavedCities extends StatelessWidget {
  const SavedCities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  final String city = cities[index].name;
                  final String placeId = cities[index].placeId;

                  context.read<WeatherBloc>().add(FetchWeather(city: city));
                  context.read<CitiesBloc>().add(AddLatestCity(
                      cityModel: CityModel(name: city, placeId: placeId)));
                  context
                      .read<PlaceCoordinatesBloc>()
                      .add(FetchPlaceCoordinates(placeId: placeId));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
