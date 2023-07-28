import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/cities/presentation/widgets/cities_list.dart';
import 'package:pogodappka/features/places/presentation/widgets/current_location.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CitiesBloc>().add(LoadRecentSearches());
    return WillPopScope(
      onWillPop: () async {
        context.read<CitiesBloc>().add(LoadLatestCity());
        return true;
      },
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 34, 123, 196),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CitiesBloc>().add(LoadLatestCity());
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        context
                            .read<AutocompleteBloc>()
                            .add(LoadAutocomplete(searchInput: value));
                      },
                      textInputAction: TextInputAction.search,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Wpisz miasto...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CurrentLocation(),
              const CitiesList(),
            ],
          ),
        ),
      ),
    );
  }
}
