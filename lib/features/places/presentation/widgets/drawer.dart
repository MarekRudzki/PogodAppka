import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/current_location.dart';

import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 49, 228, 225),
              Color.fromARGB(255, 66, 200, 113),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AutocompleteLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.places.length,
                        itemBuilder: (context, index) => LocationListTile(
                          location: state.places[index].description,
                          callback: () {
                            String adress = state.places[index].description;
                            String city =
                                adress.substring(0, adress.indexOf(','));
                          },
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Text('Nie można załadować elementu');
              }
            },
          ),
        ),
      ),
    );
  }
}
