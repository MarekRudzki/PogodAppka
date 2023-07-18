import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/places/presentation/blocs/bloc/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 34, 123, 196),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: BlocBuilder<AutocompleteBloc, AutocompleteState>(
          builder: (context, state) {
            if (state is AutocompleteLoading) {
              return const CircularProgressIndicator();
            } else if (state is AutocompleteLoaded) {
              return Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      context
                          .read<AutocompleteBloc>()
                          .add(LoadAutocomplete(searchInput: value));
                    },
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Wpisz miasto...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.gps_fixed,
                        size: 26,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Użyj Twojej lokalizacji',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.places.length,
                      itemBuilder: (context, index) => LocationListTile(
                        location: state.places[index].description,
                        callback: () {
                          print(state.places[index].description);
                        },
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
