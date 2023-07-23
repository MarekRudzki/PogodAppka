import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';

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
                    String city = adress.substring(0, adress.indexOf(','));
                    context.read<CitiesBloc>().add(AddLatestCity(city: city));
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.recentSearches.length,
                      itemBuilder: (context, index) => LocationListTile(
                        location: state.recentSearches[index],
                        callback: () {
                          String city = state.recentSearches[index];
                          context
                              .read<CitiesBloc>()
                              .add(AddLatestCity(city: city));
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
